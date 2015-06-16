use strict;
use warnings;

use Test::More tests => 1;

use Path::Tiny;
use HiD;

my $dest = path('t/published');
$dest->mkpath;

my $hid = HiD->new(
    source      => 't/corpus/src',
    layout_dir  => 't/corpus/layouts',
    destination => $dest->stringify,
);

# TODO will also grab the tests in t. 
# but it'll do for now
$hid->publish;


