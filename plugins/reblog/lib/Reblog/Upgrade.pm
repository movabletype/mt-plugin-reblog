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

1;
