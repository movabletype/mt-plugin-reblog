package Reblog::Upgrade::Legacy::ReblogSourcefeed;

use strict;
use warnings;

use base qw( MT::Object );

@Reblog::ReblogSourcefeed::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id'                   => 'integer not null auto_increment',
        'blog_id'              => 'integer not null',
        'label'                => 'string(255)',
        'url'                  => 'string(255) not null',
        'is_active'            => 'boolean not null',
        'is_excerpted'         => 'boolean not null',
        'category_id'          => 'integer',
        'epoch_last_read'      => 'integer',
        'epoch_last_fired'     => 'integer',
        'total_failures'       => 'integer',
        'consecutive_failures' => 'integer',
        'has_error'            => 'boolean not null',
    },
    indexes => {
        blog_id => 1,
        url     => 1,
    },
    audit       => 1,
    datasource  => 'reblog_sourcefeed',
    primary_key => 'id',
});

1;
