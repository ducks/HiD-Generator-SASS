use strict;
use warnings;

use Test::More tests => 2;

use Path::Tiny;
use lib '/home/ducks/dev/HiD/lib';
use HiD;
use HiD::Generator::SASS;

my $dest = path('t/published');
$dest->mkpath;

my $hid = HiD->new(
    source      => 't/corpus/src',
    layout_dir  => 't/corpus/layouts',
    destination => $dest->stringify,
    sass => {
      sass_sources => ['t/corpus/src/sass'],
      sass_output => $dest->stringify . '/css/', 
    },
    plugins => [HiD::Generator::SASS->new],
);

# TODO will also grab the tests in t.
# but it'll do for now
$hid->publish;

my $test = $dest->child('css/test.css');

ok -e $test, "now we should have a bogus css page...";

is $test->slurp => ".this{color:#fff}.this .is{color:#000}.this .is .a{color:#f00}.this .is .a .test{color:#666}", 'with the right content';
