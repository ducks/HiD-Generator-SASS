use strict;
use warnings;

use Test::More tests => 2;

use Path::Tiny;
use HiD;
use HiD::Generator::SASS;

my $dest = path('t/published');
$dest->mkpath;

my $hid = HiD->new(
    source      => 't/corpus/src',
    layout_dir  => 't/corpus/layouts',
    destination => $dest->stringify,
    plugins => [ HiD::Generator::SASS->new ],
);

# TODO will also grab the tests in t. 
# but it'll do for now
$hid->publish;

my $bogus = $dest->child('bogus.css');

ok -e $bogus, "now we should have a bogus css page...";

is $bogus->slurp => "it's a start", 'with the right content';



