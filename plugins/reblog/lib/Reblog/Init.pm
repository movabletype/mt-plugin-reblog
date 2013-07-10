package Reblog::Init;

use strict;
use warnings;

# If this is an upgrade from an older version of Reblog, data needs to be
# migrated. If this is an upgrade with an old schema version, install the
# legacy object columns so that data can be migrated.
sub init_app {
    my ( $plugin, $app, $params ) = @_;

    # Quit if this isn't an upgrade.
    return if $app->id ne 'upgrade';

    my $plugin_schema_version = MT->config('PluginSchemaVersion') || {};

    # Quit if the schema has already been updated to the abbreviated version.
    return if $plugin_schema_version->{'reblog'} > 3;

    # Install the legacy object types so that data can be migrated to the new
    # object types.
    $plugin->{registry}->{object_types}->{ReblogData}
        = 'Reblog::Upgrade::Legacy::ReblogData';
    $plugin->{registry}->{object_types}->{ReblogSourcefeed_Legacy}
        = 'Reblog::Upgrade::Legacy::ReblogSourcefeed';
}

1;
