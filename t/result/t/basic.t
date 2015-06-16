use strict;
use warnings;

use Test::More tests => 1;

use Path::Tiny;
use HiD;

my $dest = path('t/result');
$dest->mkpath;

my $hid = HiD->new(
    source      => 't/corpus/src',
    layout_dir  => 't/corpus/layouts',
    destination => $dest->stringify,
    ext => 'html',
);

$hid->publish;



