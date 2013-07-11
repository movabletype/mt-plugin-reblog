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
# $Id: ReblogData.pm 17902 2009-04-07 02:16:15Z steve $

package Reblog::ReblogData;
use strict;

use base qw( MT::Object );

@Reblog::ReblogData::ISA = qw( MT::Object );
__PACKAGE__->install_properties(
    {
        column_defs => {
            'id'             => 'integer not null auto_increment',
            'entry_id'       => 'integer not null',
            'sourcefeed_id'  => 'integer not null',
            'blog_id'        => 'integer not null',
            'link'           => 'text',
            'guid'           => 'string(255)',
            'via_link'       => 'text',
            'src'            => 'text',
            'src_author'     => 'string(255)',
            'src_created_on' => 'datetime not null',
            'src_feed_url'   => 'string(255)',
            'src_url'        => 'text',
            'src_title'      => 'text',
            'thumbnail_url'  => 'text',
            'thumbnail_link' => 'text',
            'encl_length'    => 'string(255)',
            'encl_type'      => 'string(255)',
            'encl_url'       => 'text',
            'annotation'     => 'text',
        },
        indexes => {
            created_on    => 1, # Added by the audit flag
            sourcefeed_id => 1,
            entry_id      => 1,
            guid          => 1,
        },
        audit       => 1,
        datasource  => 'reblog_data',
        primary_key => 'id',
    }
);

# Override the default column method to trim long strings
sub column {
    my $self = shift;

    if ( defined $_[1] ) {

        # Setting a value
        my $def = $self->column_def( $_[0] );
        if (   $def->{type} eq 'string'
            && $def->{size} == 255
            && length( $_[1] ) > 255 )
        {

            # if it's a string(255) and the value is longer than 255 chars
            # grab the first 255 and leave it at that
            $_[1] = substr( $_[1], 0, 255 );
        }
    }

    $self->SUPER::column(@_);
}

1;

