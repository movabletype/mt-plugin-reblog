package Reblog::Upgrade::Legacy::ReblogData;

use strict;
use warnings;

use base qw( MT::Object );

@Reblog::ReblogData::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id'               => 'integer not null auto_increment',
        'entry_id'         => 'integer not null',
        'sourcefeed_id'    => 'integer not null',
        'blog_id'          => 'integer not null',
        'link'             => 'string(255)',
        'guid'             => 'string(255)',
        'source_author'    => 'string(255)',
        'src_author'       => 'string(255)', # New column name
        'via_link'         => 'string(255)',
        'orig_created_on'  => 'datetime allow null',
        'src_created_on'   => 'datetime not null', # New column name
        'source'           => 'string(255)',
        'src'              => 'string(255)', # New column name
        'source_url'       => 'string(255)',
        'src_url'          => 'string(255)', # New column name
        'source_feed_url'  => 'string(255)',
        'src_feed_url'     => 'string(255)', # New column name
        'source_title'     => 'string(255)',
        'src_title'        => 'string(255)', # New column name
        'thumbnail_url'    => 'string(255)',
        'thumbnail_link'   => 'string(255)',
        'enclosure_url'    => 'string(255)',
        'encl_url'         => 'string(255)', # New column name
        'enclosure_length' => 'string(255)',
        'encl_length'      => 'string(255)', # New column name
        'enclosure_type'   => 'string(255)',
        'encl_type'        => 'string(255)', # New column name
        'annotation'       => 'text'
    },
    indexes => {
        created_on    => 1,
        sourcefeed_id => 1,
        entry_id      => 1,
        guid          => 1,
    },
    audit       => 1,
    datasource  => 'reblog_data',
    primary_key => 'id',
});

1;
