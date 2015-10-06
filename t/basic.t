use strict;
use warnings;

use Test::More tests => 1;

use Path::Tiny;
use HiD;
use HiD::Generator::Sass;
use Data::Printer;

chdir 't/corpus';

my $dest = path('published/');

unless ($dest->exists) {
  $dest->mkpath;
}

my $hid = HiD->new(
    source      => 'src',
    layout_dir  => 'layouts',
    destination => $dest->stringify,
    config => { 
      sass => {
        sass_sources => [
          'src/sass/test.scss'
        ],
        sass_output => '/css/',
      },
    },
    plugins => [HiD::Generator::Sass->new],
);

# TODO will also grab the tests in t.
# but it'll do for now
$hid->publish;

my $test = $dest->child('css/test.css');

ok -e $test, "now we should have a bogus css page...";
