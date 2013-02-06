#Reblog

Reblog is a Movable Type plugin that parses Atom and RSS feeds and transforms feed entries into Movable Type entries. Imports can be run either manually or in the background using [run-periodic-tasks](http://www.movabletype.org/documentation/administrator/setting-up-run-periodic-taskspl.html).

# Dependencies

Reblog Version 2.3 supports the following versions of Movable Type:

* Movable Type 4.25 or later
* Movable Type 5.0x
* Movable Type 5.1x
* Movable Type 5.2.x

Note: There is currently a [reported problem with Reblog 2.3 and Movable Type 5](https://github.com/movabletype/mt-plugin-reblog/issues/5) that may be a bug in the Movable Type core.

## Additional Perl Module Requirements

In addition to the [System Requirements](http://www.movabletype.org/documentation/system-requirements.html) for Movable Type, Reblog requires the following Perl modules:

* [DateTime](http://search.cpan.org/~drolsky/DateTime-0.78/lib/DateTime.pm)
* [Date::Parse](http://search.cpan.org/~gbarr/TimeDate-1.20/lib/Date/Parse.pm)
* [Switch](http://search.cpan.org/~rgarcia/Switch-2.16/Switch.pm)

## Optional Perl Modules

To improve the performance of Reblog, the following modules may also be installed.

* [XML::Liberal](http://search.cpan.org/~miyagawa/XML-Liberal-0.22/lib/XML/Liberal.pm)
* [XML::LibXML](http://search.cpan.org/~shlomif/XML-LibXML-2.0012/LibXML.pod)

Movable Type developers may also wish to install:

* Six Apart's [MT::Test](https://github.com/movabletype/movable-type-test) for running unit tests.

# Installation

Install the Perl modules discussed above using installation procedures for [CPAN](http://www.cpan.org), [CPANminus](https://raw.github.com/miyagawa/cpanminus/master/cpanm), [PPM](http://code.activestate.com/ppm/), or the packaging system that is supported by your operating system.

After downloading and uncompressing this package:

1. Upload the entire Reblog directory within the plugins directory of this distribution to the corresponding plugins directory within the Movable Type installation directory.
    * UNIX example:
        * Copy mt-plugin-reblog/plugins/reblog/ into /var/wwww/cgi-bin/mt/plugins/.
    * Windows example:
        * Copy mt-plugin-reblog/plugins/reblog/ into C:\webroot\mt-cgi\plugins\ .

*Note*: If you are using Reblog in an installation of Movable Type 5.0 or greater, we strongly recommend installing the [CreateAndManage plugin](https://github.com/After6Services/mt-plugin-create-and-manage), available at [https://github.com/After6Services/mt-plugin-create-and-manage](https://github.com/After6Services/mt-plugin-create-and-manage).  Otherwise, the user interface discussed in the Configuration section below will not appear as expected.

# Configuration

Once installed, this plugin appears under the Manage menu in each blog in two places:

Manage > Reblog

Manage > Sourcefeeds

# Additional Documentation

Additional documentation is located at [https://github.com/movabletype/mt-plugin-reblog/wiki](https://github.com/movabletype/mt-plugin-reblog/wiki).

# License

This plugin is [version 2 of the GNU General Public License](http://opensource.org/licenses/GPL-2.0).   See LICENSE.md for the exact license.

# Authorship

This plugin has been contributed to by many current and former employees of Six Apart, Ltd., After6 Services, 601am, Endevver, and YesItCan.be.  See the [Credits page](https://github.com/movabletype/mt-plugin-reblog/wiki/Credits) on the Reblog wiki for a list of specific individuals who have contributed.

The Reblog concept was initially developed at [Reblog.org](http://www.reblog.org/) by the [Eyebeam Art and Technology Center](http://www.eyebeam.org/), [Stamen Design](http://stamen.com/), and other contributors. 

# Copyright

Copyright © 2007 - 2012, Six Apart Ltd.  All Rights Reserved.

Enhancements to update frequencies and hierarchical category support, additional documentation, Copyright © 2011-2013, After6 Services LLC.  All Rights Reserved.

Additional documentation contained in the Wiki, Copyright © 2011-2012, 601am LLC.  All Rights Reserved.
