
use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';

use MT;
use MT::Test qw( :db );

use Test::More tests => 18;

ok (MT->model ('ReblogData'), "Model for ReblogData");

my $rd = MT->model ('ReblogData')->new;
ok ($rd, "ReblogData created");

$rd->entry_id(1);
$rd->link('http://narnia.na/reblog_link');
$rd->guid('guid:unique_id,1');
$rd->src_author('mkania');
$rd->via_link('http://narnia.na/via_link');
$rd->src_created_on('2008-12-04 15:30:00');
$rd->src('Narnia Blog');
$rd->src_url('http://narnia.na');
$rd->src_feed_url('http://narnia.na/source.xml');
$rd->src_title('Narnia Blog');
$rd->thumbnail_url('http://narnia.na/thumbnail.jpg');
$rd->thumbnail_link('http://narnia.na/thumbnail_link');
$rd->encl_url('http://narnia.na/full.jpg');
$rd->encl_length(10000);
$rd->encl_type('image/jpeg');
$rd->annotation('annotation');
$rd->save;

is($rd->entry_id, 1, "Entry ID");
is($rd->link, 'http://narnia.na/reblog_link', "Reblog Link");
is($rd->guid, 'guid:unique_id,1', "Reblog GUID");
is($rd->src_author, 'mkania', "Reblog Source Author");
is($rd->via_link, 'http://narnia.na/via_link', "Reblog Via Link");
is($rd->src_created_on, '2008-12-04 15:30:00', "Reblog Original Created On");
is($rd->src, 'Narnia Blog', "Reblog Source");
is($rd->src_url, 'http://narnia.na', "Reblog Source URL");
is($rd->src_feed_url, 'http://narnia.na/source.xml', "Reblog Source Feed URL");
is($rd->src_title, 'Narnia Blog', "Reblog Source Title");
is($rd->thumbnail_url, 'http://narnia.na/thumbnail.jpg', "Reblog Thumbnail URL");
is($rd->thumbnail_link, 'http://narnia.na/thumbnail_link', "Reblog Thumbnail Link");
is($rd->encl_url, 'http://narnia.na/full.jpg', "Reblog Enclosure URL");
is($rd->encl_length, 10000, "Reblog Enclosure Length");
is($rd->encl_type, 'image/jpeg', "Reblog Enclosure Type");
is($rd->annotation, 'annotation', "Reblog Annotation");