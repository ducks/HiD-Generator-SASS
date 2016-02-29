package HiD::Generator::Sass;

# ABSTRACT: Compile Sass files to CSS

=head1 SYNOPSIS

You will need to install the HiD::Generator::Sass.
Then, add the HiD::Generator::Sass plugin to the list and set up
the sass_sources input files and sass_output files.

In F<_config.yml>:

   config => {
      sass => {
        sass_sources => [
          '_t/corpus/src/sass/test.scss'
        ],
        sass_output => '/css/',
      },
    },
    plugins => [HiD::Generator::Sass->new],

=head1 DESCRIPTION

HiD::Generator::Sass is a plugin for the HiD static blog system
that uses the perl wrapper for libSass to compile your sass files
into css.

=cut

use Moose;
with 'HiD::Generator';
use File::Find::Rule;
use Path::Tiny;
use CSS::Sass;

use 5.014;

use HiD::VirtualPage;

=method generate

=cut

sub generate {
  my($self, $site) = @_;

  my @sass_sources = @{ $site->config->{sass}{sass_sources} || [] };

  my $sass_style;
  $sass_style = eval $site->config->{sass}{sass_style} if $site->config->{sass}{sass_style};

  # give it a default value is nothing is passed
  $sass_style //= SASS_STYLE_NESTED;

  my $sass = CSS::Sass->new( output_style  => $sass_style );

  foreach my $file (@sass_sources) {
    $site->INFO("* Compiling sass file - " . $file);
    my $css = $sass->compile_file($file);
    my $filename = path($file)->basename('.scss');

    my $css_file = HiD::VirtualPage->new({
      content => $css,
      output_filename => $site->destination .
                         $site->config->{sass}{sass_output} .
                         $filename .
                         '.css'
    });

    $site->add_object($css_file);
  }

  $site->INFO("* Compiled sass files successfully!");
}

__PACKAGE__->meta->make_immutable;
1;
