Reblog is a Movable Type plugin that parses Atom and RSS feeds and transforms feed entries into MT entries. Imports can be run either manually or in the background using run-periodic-tasks.

# Dependencies

Reblog Version 2.3 supports the following versions of Movable Type:

* Movable Type 4.25 or later
* Movable Type 5.0x
* Movable Type 5.1x

## Additional Required Perl Modules

Beyond the CPAN modules included in MT's extlib directory, the following modules are required:

* DateTime
* Date::Parse
* Switch

## Optional Perl Modules

To improve the performance of reblog, the following modules may also be installed.

* XML::Liberal
* XML::LibXML

Movable Type developers may also wish to install:

* Six Apart's MT::Test (<https://github.com/movabletype/movable-type-test>) for running unit tests

# Installation

After downloading this package, upload the entire reblog directory within the plugins directory of this distribution to the corresponding plugins directory within the Movable Type installation directory.

# Configuration

Once installed, this plugin appears under the Manage menu in each blog in two places:

Manage > Reblog
Manage > Sourcefeeds

# Additional Documentation

Additional documentation is located at https://github.com/movabletype/mt-plugin-reblog/wiki.

# License

This plugin is licensed under the GPL.

# Copyright

Copyright © 2007 - 2009, Six Apart Ltd.
Enhancements to update frequencies and hierarchical category support, Copyright © 2011, After6 Services LLC.
