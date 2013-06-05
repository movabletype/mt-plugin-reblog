package Reblog::Upgrade;

use strict;
use warnings;

sub sourcefeed_label_load {
    print "Inserting reblog labels...\n";
    use Reblog::ReblogSourcefeed;
    my @feeds = Reblog::ReblogSourcefeed->load();
    foreach my $feed (@feeds) {
        if ( !$feed->label ) {
            my $label = $feed->url;
            $label =~ s/^http(s?):\/\///;
            $label =~ s/\/.*//;
            unless ($label) {
                $label = "Feed No. " . $feed->id;
                print "Feed with bad label: feed id " . $feed->id;
            }
            $feed->label($label);
            $feed->save;
        }
    }
    return 1;
}

sub data_sourcefeedid_load {
    print "Inserting reblog sourcefeed and blog ID data...\n";
    my @rbds = Reblog::ReblogData->load( {} );
    foreach my $rbd (@rbds) {
        my $entry = MT::Entry->load( $rbd->entry_id );
        if ( !$entry ) {
            $rbd->blog_id(0);
            $rbd->sourcefeed_id(0);
            $rbd->save;
            next;
        }
        my @sourcefeeds
            = Reblog::ReblogSourcefeed->load(
            { blog_id => $entry->blog_id, url => $rbd->src_feed_url },
            { limit   => 1 } );
        my $sourcefeed = pop @sourcefeeds;
        if ($sourcefeed) {
            $rbd->sourcefeed_id( $sourcefeed->id );
            $rbd->blog_id( $entry->blog_id );
            $rbd->save;
        }
        else {
            $rbd->blog_id( $entry->blog_id );
            $rbd->sourcefeed_id(0);
            $rbd->save;
        }
    }
    return 1;
}

# -When updating the database-, for each blog in the system, we want to see if
# we can find a sourceg to insert into mt_reblog_sourcefeed
sub initial_sourcefeed_load {
    my @blogs = MT::Blog->load( {} );
    foreach my $blog (@blogs) {
        my $pref = $blog->id() . "-";
        my $data = MT::PluginData->load(
            { plugin => 'reblog', key => $pref . "source_rss" } );
        if ( defined($data) && $data ) {
            print "Inserting initial feed for blog#"
                . $blog->id() . ": "
                . ${ $data->data() } . "\n";
            my $sourcefeed = new Reblog::ReblogSourcefeed;
            $sourcefeed->blog_id( $blog->id() );
            $sourcefeed->is_active(1);
            $sourcefeed->url( ${ $data->data() } );
            $sourcefeed->save();
        }
    }
    return 1;
}

# Abbreviated column names are needed for Oracle. Copy any data in the original
# long-named columns to the new short-named columns so that user data continues
# to work as expected. Note that in the init callback the legacy table/column
# names are inserted into the registry so that this can run.
sub upgrade_column_names_data {
    my $app = shift;

    # Update the Reblog Sourcefeed table, moving all data from the old table to
    # the new Oracle-compatible table.
    my %columns = (
        # Old column name         New column name
        # reblog_sourcefeed       reblog_srcfd
        'id'                   => 'id',
        'blog_id'              => 'blog_id',
        'label'                => 'label',
        'url'                  => 'url',
        'is_active'            => 'is_active',
        'is_excerpted'         => 'is_excerpted',
        'category_id'          => 'category_id',
        'epoch_last_read'      => 'last_read',
        'epoch_last_fired'     => 'last_fired',
        'total_failures'       => 'total_fails',
        'consecutive_failures' => 'consec_fails',
        'has_error'            => 'has_error',
    );

    my $iter = MT->model('ReblogSourcefeed_Legacy')->load_iter();
    my $counter = 0;
    while ( my $orig_record = $iter->() ) {
        my $new_record = MT->model('ReblogSourcefeed')->new();
        while ( my ($old_key, $new_key) = each (%columns) ) {
            # Copy datafrom the old record and old column to the new record and
            # new column.
            $new_record->$new_key( $orig_record->$old_key );
        }
        $new_record->save or die $new_record->errstr;
        $counter++;
    }
    
    $app->progress(
        "$counter reblog_sourcefeed records migrated to reblog_srcfd."
    );

    # Update the Reblog Data table. Only some column names were updated, so we
    # can just copy from one column to another.
    my %columns = (
        # Old column name     New column name
        'source'           => 'src',
        'source_author'    => 'src_author',
        'orig_created_on'  => 'src_created_on',
        'source_feed_url'  => 'src_feed_url',
        'source_url'       => 'src_url',
        'source_title'     => 'src_title',
        'enclosure_length' => 'encl_length',
        'enclosure_type'   => 'encl_type',
        'enclosure_url'    => 'encl_url',
    );

    my $iter = MT->model('ReblogData')->load_iter();
    my $counter = 0;
    while ( my $record = $iter->() ) {
        while ( my ($old_key, $new_key) = each (%columns) ) {
            # Copy data from the old column to the new column.
            $record->$new_key( $record->$old_key );
        }
        $record->save or die $record->errstr;
        $counter++;
    }

    $app->progress(
        "$counter reblog_data records migrated to reblog_data."
    );
}

1;
