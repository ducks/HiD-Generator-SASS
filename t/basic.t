use strict;
use warnings;

use Test::More tests => 2;

use Path::Tiny;
use HiD;
use HiD::Generator::Sass;

my $dest = path('t/published/');
$dest->mkpath;

my $hid = HiD->new(
    source      => 't/corpus/src',
    layout_dir  => 't/corpus/layouts',
    destination => $dest->stringify,
    config => { 
      sass => {
        sass_style => 'SASS_STYLE_COMPRESSED',
        sass_sources => [
          't/corpus/src/sass/test.scss'
        ],
        sass_output => '/css/',
      },
    },
    plugins => [HiD::Generator::Sass->new],
);

# TODO will also grab the tests in t.
# but it'll do for now
$hid->publish;

my $test = $dest->child('/css/test.css');

ok -e $test, "now we should have a bogus css page...";

is $test->slurp => ".this{color:#fff}.this .is{color:#000}.this .is .a{color:#f00}.this .is .a .test{color:#666}\n", 'with the right content';
