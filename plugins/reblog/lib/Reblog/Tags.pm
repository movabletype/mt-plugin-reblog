#############################################################################
# Copyright © 2007-2009 Six Apart Ltd.
# Copyright © 2011, After6 Services LLC.
# This program is free software: you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details.  You should have received a copy of the GNU
# General Public License version 2 along with this program. If not, see
# <http://www.gnu.org/licenses/>.
# $Id: Tags.pm 18797 2009-04-21 12:22:59Z steve $

package Reblog::Tags;
use strict;
use warnings;
use Switch;

###########################################################################

=head2 IfReblog block tag

=cut

sub _hdlr_if_reblog {
    my ( $ctx, $args ) = @_;
    my ( $blog, $blog_id );
    $blog_id = $args->{blog_id};
    if ($blog_id) {
        use MT::Blog;
        $blog = MT::Blog->load($blog_id);
    }
    else {
        $blog = $ctx->stash('blog');
    }
    ($blog) or return $ctx->error('No blog in context');
    require Reblog::ReblogSourcefeed;
    my @sf = Reblog::ReblogSourcefeed->load(
        { blog_id => $blog->id, is_active => 1 } );
    return scalar @sf;
}

###########################################################################

=head2 IfNotReblog block tag

=cut

sub _hdlr_if_not_reblog {
    my ( $ctx, $args ) = @_;
    my ( $blog, $blog_id );
    $blog_id = $args->{blog_id};
    if ($blog_id) {
        use MT::Blog;
        $blog = MT::Blog->load($blog_id);
    }
    else {
        $blog = $ctx->stash('blog');
    }
    ($blog) or return $ctx->error('No blog in context');
    require Reblog::ReblogSourcefeed;
    my @sf = Reblog::ReblogSourcefeed->load(
        { blog_id => $blog->id, is_active => 1 } );
    return ( !scalar @sf );
}

###########################################################################

=head2 EntryIfReblog block tag

=cut

sub _hdlr_entry_if_reblog {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryIfReblog');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    return defined($rbd) && $rbd->id;
}

###########################################################################

=head2 EntryIfHasReblogAuthor block tag

=cut

sub _hdlr_entry_if_has_reblog_author {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryIfHasReblogAuthor');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    return defined($rbd) && $rbd && $rbd->src_author;
}

###########################################################################

=head2 EntryReblogSource function tag

=cut

sub _hdlr_entry_reblog_source {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryReblogSource');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd) && $rbd && $rbd->src ? $rbd->src : '';
}

###########################################################################

=head2 EntryReblogSourceURL and EntryReblogSourceLink function tags

=cut

sub _hdlr_entry_reblog_source_url {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryReblogSourceLink');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd) && $rbd && $rbd->src_url ? $rbd->src_url : '';
}

###########################################################################

=head2 EntryReblogSourceFeedURL and EntryReblogSourceLinkXML function tags

=cut

sub _hdlr_entry_reblog_source_feed_url {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryReblogSourceFeedURL');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd)
        && $rbd
        && $rbd->src_feed_url ? $rbd->src_feed_url : '';
}

###########################################################################

=head2 EntryReblogLink function tag

=cut

sub _hdlr_entry_reblog_link {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryReblogSourceLink');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd) && $rbd ? $rbd->link : '';
}

###########################################################################

=head2 EntryReblogSourcefeedID function tag

=cut

sub _hdlr_entry_reblog_sourcefeed_id {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryReblogSourcefeedId');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd) && $rbd ? $rbd->sourcefeed_id : '';
}

###########################################################################

=head2 EntryReblogViaLink function tag

=cut

sub _hdlr_entry_reblog_via_link {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('EntryReblogViaLink');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd) && $rbd ? $rbd->via_link ? $rbd->via_link : '' : '';
}

###########################################################################

=head2 EntryReblogSourcePublishedDate function tag

=cut

sub _hdlr_entry_reblog_orig_date {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('MTEntryReblogSourcePublishedDate');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';

    my $att = $_[1];
    eval {
        $args->{ts}
            = (
            $rbd ? MT::Object->driver()->db2ts( $rbd->src_created_on ) : 0 );
    };
    if ($@) {
        $args->{ts} = $rbd->src_created_on;
    }

    defined($rbd) && $rbd
        ? MT::Template::Context::_hdlr_date( $_[0], $args )
        : '';
}

###########################################################################

=head2 EntryReblogSourceAuthor and EntryReblogAuthor function tags

=cut

sub _hdlr_entry_reblog_source_author {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('MTEntryReblogSourceAuthor');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';
    defined($rbd) && $rbd ? $rbd->src_author : '';
}

###########################################################################

=head2 EntryReblogIdentifier function tag

=cut

sub _hdlr_entry_reblog_identifier {
    my ( $ctx, $args ) = @_;

    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error('MTEntryReblogIdentifier');

    require Reblog::ReblogData;
    my $rbd = Reblog::ReblogData->load( { entry_id => $entry->id } )
        or return '';

    defined($rbd) && $rbd ? $rbd->guid : '';
}

###########################################################################

=head2 EntryReblogThumbnailImg function tag

=cut

sub _hdlr_entry_reblog_thumbnail_url {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );
    ( $reblog && $reblog->thumbnail_url )
        ? return $reblog->thumbnail_url
        : return '';
}

###########################################################################

=head2 EntryReblogThumnbailLink function tag

=cut

sub _hdlr_entry_reblog_thumbnail_link {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );
    ( $reblog && $reblog->thumbnail_link )
        ? return $reblog->thumbnail_link
        : return '#';
}

###########################################################################

=head2 EntryReblogSourceTitle function tag

=cut

sub _hdlr_entry_reblog_orig_source_title {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );
    ( $reblog && $reblog->src_title )
        ? return $reblog->src_title
        : return '';
}

###########################################################################

=head2 EntryReblogAnnotation function tag

=cut

sub _hdlr_entry_reblog_annotation {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );
    ( $reblog && $reblog->annotation )
        ? return $reblog->annotation
        : return '';
}

###########################################################################

=head2 Not used: EntryReblogFavicon (?) function tag

=cut

sub _hdlr_entry_reblog_favicon {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );
    return unless $reblog;
    my $sf = Reblog::ReblogSourcefeed->load( $reblog->sourcefeed_id );
    ( $sf && $sf->favicon_url )
        ? return $sf->favicon_url
        : return '';
}

###########################################################################

=head2 EntryReblogEnclosure function tag

=cut

sub _hdlr_entry_reblog_enclosure {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );

    if ( $reblog && $reblog->encl_url ) {
        return $reblog->encl_url;
    }
    else {
        return '';
    }
}

###########################################################################

=head2 EntryReblogEnclosureMimeType function tag

=cut

sub _hdlr_entry_reblog_enclosure_mimetype {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );

    if ( $reblog && $reblog->encl_url ) {
        return $reblog->encl_type;
    }
    else {
        return '';
    }
}

###########################################################################

=head2 EntryReblogEnclosureLength function tag

=cut

sub _hdlr_entry_reblog_enclosure_length {
    my $ctx    = shift;
    my $args   = shift;
    my $e      = $ctx->stash('entry') or return;
    my $reblog = Reblog::ReblogData->load( { entry_id => $e->id } );

    if ( $reblog && $reblog->encl_length ) {
        return $reblog->encl_length;
    }
    elsif ($reblog) {
        require LWP::UserAgent;
        my $ua      = LWP::UserAgent->new();
        my $headers = $ua->head( $reblog->encl_url );
        if ( $headers && $headers->content_length ) {
            $reblog->encl_length( $headers->content_length );
        }
        else {
            $reblog->encl_length(-1)
                ;  # set it to a nonzero value so we don't try to get it again
        }
        $reblog->save;
        return $reblog->encl_length;
    }
    else {
        return '';
    }
}

###########################################################################

=head2 ReblogEnclosureEntries block tag

=cut

sub _hdlr_reblog_enclosure_entries {
    my ( $ctx, $args, $cond ) = @_;

    my $blog_id = $ctx->stash('blog_id');

    require MT::Entry;
    require Reblog::ReblogData;
    my @entries = MT::Entry->load(
        { blog_id => $blog_id, status => MT::Entry::RELEASE },
        { join => Reblog::ReblogData->join_on('entry_id') }
    );

    @entries = grep {
        my $rdb = Reblog::ReblogData->load( { entry_id => $_->id } );
        $rdb->encl_url;
    } @entries;

    return '' if ( !scalar @entries );

    my $out     = "";
    my $builder = $ctx->stash('builder');
    my $tokens  = $ctx->stash('tokens');
    foreach my $entry (@entries) {
        $ctx->stash( "entry", $entry );
        $out .= $builder->build( $ctx, $tokens, $cond );
    }
    return $out;
}

###########################################################################

=head2 ReblogEntries block tag

=cut

sub _hdlr_reblog_entries {
    my ( $ctx, $args, $cond ) = @_;
    my ( $limit, $offset );
    my ( $sourcefeed, $sourcefeed_url, $sourcefeed_id );
    $sourcefeed_id = 0;
    my $res     = '';
    my $builder = $ctx->stash('builder');
    my $tokens  = $ctx->stash('tokens');
    my $blog_id = $ctx->stash('blog_id');

    my @entries;
    $offset = $args->{offset} ? $args->{offset} : 0;

    my %query_args;
    $query_args{'sort'}      = 'src_created_on';
    $query_args{'direction'} = 'descend';
    $query_args{'offset'}    = $offset;

    if ( $args->{limit} ) {
        $query_args{'limit'} = $args->{limit};
    }
    elsif ( $args->{lastn} ) {
        $query_args{'limit'} = $args->{lastn};
    }

    # Set sourcefeed restriction
    if ( $args->{sourcefeed} ) {
        $sourcefeed_url = $args->{sourcefeed};
    }
    elsif ( $args->{sourcefeed_id} ) {
        $sourcefeed_id = $args->{sourcefeed_id};
    }
    elsif ( $args->{sourcefeed_label} ) {
        $sourcefeed = Reblog::ReblogSourcefeed->load(
            { blog_id => $blog_id, label => $args->{sourcefeed_label} } );
        return '' if ( ! $sourcefeed );
        $sourcefeed_id = $sourcefeed->id;
    }
    elsif ( $args->{sourcefeed_url} ) {
        $sourcefeed = Reblog::ReblogSourcefeed->load(
            { blog_id => $blog_id, url => $args->{sourcefeed_url} } );
        return '' if ( ! $sourcefeed );
        $sourcefeed_id = $sourcefeed->id;
    }
    elsif ( $ctx->stash('reblog_source') ) {
        my $source = $ctx->stash('reblog_source');
        $sourcefeed_id = $source->{id};
    }
    my $sourceargs;
    if ($sourcefeed_id) {
        $sourceargs->{sourcefeed_id} = $sourcefeed_id;
    }
    elsif ($sourcefeed_url) {
        $sourceargs->{source_feed_url} = $sourcefeed_url;
    }

    # Actually do load
    my $e_iter = MT::Entry->load_iter(
        { blog_id => $blog_id, status => MT::Entry::RELEASE() },
        {   'join' => [
                'Reblog::ReblogData', 'entry_id',
                $sourceargs,          \%query_args
            ]
        }
    );

    my $i = 0;
    my $entry = $e_iter->();
    while ( $entry ) {
        my $next = $e_iter->();
        local $ctx->{__stash}{entry}         = $entry;
        local $ctx->{current_timestamp}      = $entry->authored_on;
        local $ctx->{modification_timestamp} = $entry->modified_on;

        my $vars = $ctx->{__stash}{vars} ||= {};
        local $vars->{__first__}   = !$i;
        local $vars->{__last__}    = !$next;
        local $vars->{__odd__}     = ( $i % 2 ) == 0;             # 0-based $i
        local $vars->{__even__}    = ( $i % 2 ) == 1;
        local $vars->{__counter__} = $i + 1;

        defined(
            my $out = $builder->build(
                $ctx, $tokens,
                {   EntryIfExtended => $entry->text_more ? 1 : 0,
                    EntryIfAllowComments => $entry->allow_comments,
                    EntryIfAllowPings    => $entry->allow_pings
                }
            )
        ) or return $ctx->error( $ctx->errstr );
        $res .= $out;
        $i++;
        last if ( ! $next );
        $entry = $next;
    }
    $res;
}

###########################################################################

=head2 ReblogSourcefeeds block tag

=cut

sub _hdlr_reblog_sourcefeeds {
    my ( $ctx, $args, $cond ) = @_;

    my $res     = '';
    my $builder = $ctx->stash('builder');
    my $tokens  = $ctx->stash('tokens');
    my $blog    = $ctx->stash('blog');

    my $blog_id;
    if ( $args->{blog_id} ) {
        $blog_id = $args->{blog_id};
    }
    else {
        ($blog) or return $ctx->error('No blog in context');
        $blog_id = $blog->id;
    }
    my $arguments;
    if ( $args->{id} ) {
        $arguments->{id} = $args->{id};
    }
    elsif ( $args->{url} ) {
        $arguments->{url} = $args->{url};
    }
    elsif ( $args->{label} ) {
        $arguments->{label} = $args->{label};
    }
    $arguments->{blog_id} = $blog_id;
    if ( $args->{active_only} ) {
        $arguments->{is_active} = 1;
    }
    my $sourcefeed_iter = Reblog::ReblogSourcefeed->load_iter( $arguments, );
    my @sources;
    while ( my $sourcefeed = $sourcefeed_iter->() ) {
        my ( $title, $url ) = ( $sourcefeed->label, $sourcefeed->url );
        my $last
            = Reblog::ReblogData->load( { sourcefeed_id => $sourcefeed->id },
            { limit => 1 } );
        if ($last) {
            $title = $last->src;
            $url   = $last->src_url;
        }
        push @sources,
            {
            id         => $sourcefeed->id,
            url        => $url,
            feed_url   => $sourcefeed->url,
            label      => $sourcefeed->label,
            title      => $title,
            sourcefeed => $sourcefeed,
            };
    }
    my ( $limit, $offset ) = ( 0, 0 );
    if ( $args->{offset} and $args->{offset} =~ m/^\d+$/ ) {
        $offset = $args->{offset};
    }
    if ( $args->{limit} and $args->{limit} =~ m/^\d+$/ ) {
        $limit = $args->{limit};
    }
    my @slice;
    if ($limit) {
        my $end = $offset + $limit - 1;
        @slice = @sources[ $offset .. $end ];
    }
    else {
        my $end = scalar @sources - 1;
        @slice = @sources[ $offset .. $end ];
    }
    if ( $args->{sort} ) {
        switch ( $args->{sort} ) {
            case q{title} {
                @slice = map { $_->[0] }
                    sort { $a->[1] cmp $b->[1] }
                    map { [ $_, $_->{title} ] } @slice;
            }
            case q{label} {
                @slice = map { $_->[0] }
                    sort { $a->[1] cmp $b->[1] }
                    map { [ $_, $_->{label} ] } @slice;
            }
            case q{last_checked} {
                @slice = map { $_->[0] }
                    sort {
                    return 1
                        if ( !defined $a->[1] );
                    return -1 if ( !defined $b->[1] );
                    $a->[1] <=> $b->[1]
                    }
                    map { [ $_, $_->{sourcefeed}->last_read ] } @slice;
            }
        }
    }
    my $i = 0;
    foreach my $source (@slice) {
        next if ( !defined $source );
        my $vars = $ctx->{__stash}{vars} ||= {};
        local $vars->{__first__}   = !$i;
        local $vars->{__last__}    = !defined $slice[ $i + 1 ];
        local $vars->{__odd__}     = ( $i % 2 ) == 0;             # 0-based $i
        local $vars->{__even__}    = ( $i % 2 ) == 1;
        local $vars->{__counter__} = $i + 1;
        $ctx->stash( 'reblog_source', $source );
        defined( my $out = $builder->build( $ctx, $tokens ) )
            or return $ctx->error( $ctx->errstr );
        $res .= $out;
        $i++;
    }
    return $res;
}

###########################################################################

=head2 ReblogSourceURL and ReblogSourceLink function tags

=cut

sub _hdlr_reblog_source_url {
    my $ctx = shift;
    my $f   = $ctx->stash('reblog_source');
    return $f->{url} ? $f->{url} : '';
}

###########################################################################

=head2 Not used: ReblogSourceFavicon (?) function tag

=cut

sub _hdlr_reblog_source_favicon {
    my $ctx = shift;
    my $f   = $ctx->stash('reblog_source');
    return unless $f->{id};
    my $sf = Reblog::ReblogSourcefeed->load( $f->{id} );
    return unless $sf;
    return $sf->favicon_url;
}

###########################################################################

=head2 ReblogSourceFeedURL and ReblogSourceXMLLink function tags

=cut

sub _hdlr_reblog_source_feed_url {
    my $ctx = shift;
    my $f   = $ctx->stash('reblog_source');
    return $f->{feed_url} ? $f->{feed_url} : '';
}

###########################################################################

=head2 ReblogSourceID function tag

=cut

sub _hdlr_reblog_source_id {
    my $ctx = shift;
    my $f   = $ctx->stash('reblog_source');
    return $f->{id} ? $f->{id} : '';
}

###########################################################################

=head2 ReblogSource function tag

=cut

sub _hdlr_reblog_source {
    my $ctx = shift;
    my $f   = $ctx->stash('reblog_source');
    return $f->{title} ? $f->{title} : '';
}

###########################################################################

=head2 ReblogSourceLabel function tag

=cut

sub _hdlr_reblog_label {
    my $ctx = shift;
    my $f   = $ctx->stash('reblog_source');
    return $f->{label} ? $f->{label} : '';
}

###########################################################################

=head2 Not used: ReblogFaviconURL (?) function tag

=cut

sub _hdlr_reblog_favicon {
    my $ctx  = shift;
    my $args = shift;
    my $f    = $ctx->stash('reblog_source');
    if ($f) {
        my $sf = Reblog::ReblogSourcefeed->load( $f->{id} );
        return unless $sf;
        return $sf->favicon_url;
    }
    else {
        my $id = $args->{id};
        return unless $id;
        my $sf = Reblog::ReblogSourcefeed->load($id);
        return unless $sf;
        return $sf->favicon_url;
    }
}

1;
