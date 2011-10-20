Reblog is a Movable Type plugin that parses Atom and RSS feeds and transforms feed entries into MT entries. Imports can be run either manually or in the background using run-periodic-tasks.

DEPENDENCIES
Movable Type 4.25 or later, including Movable Type 5.0x and 5.1x.

Beyond the CPAN modules included in MT's extlib directory, the following modules are required:
    * DateTime
    * Date::Parse
    * Switch

Optional modules:
    * XML::Liberal
    * XML::LibXML
    * Six Apart Services' MT::Test (<http://github.com/sixapart/movable-type-test/tree/master>) for running unit tests

INSTALLATION

After downloading this package, upload the entire reblog directory within the plugins directory of this distribution to the corresponding plugins directory within the Movable Type installation directory.

CONFIGURATION

Once installed, this plugin appears under the Manage menu in each blog in two places:

Manage > Reblog
Manage > Sourcefeeds

ADDITIONAL DOCUMENTATION

Additional documentation is located at https://github.com/movabletype/mt-plugin-reblog/wiki.

LICENSE

This plugin is licensed under the GPL.

COPYRIGHT

Copyright © 2007 - 2009, Six Apart Ltd.
Enhancements to update frequencies and hierarchical category support, Copyright © 2011, After6 Services LLC.
