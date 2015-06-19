package HiD::Generator::SASS;

# ABSTRACT: transform SASS files to CSS

=head1 DESCRIPTION

=cut

use Moose;
with 'HiD::Generator';
use File::Find::Rule;
use CSS::Sass;

use 5.014;

use HiD::VirtualPage;

=method generate

=cut

sub generate {
  my($self, $site) = @_;

  my @sass_sources = $site->config->{sass}{sass_sources};

  my $sass = CSS::Sass->new(
    output_style  => SASS_STYLE_COMPRESSED
  );

  foreach my $file (@sass_sources) {
    $site->INFO("* Compiling sass file - " . $file);
    # my $css = $sass->compile_file($file);
    my $filename = $file;
    $filename =~ /\/([a-zA-Z0-9]+)\./;

    # my $css_file = HiD::VirtualPage->new({
    #   content => $css,
    #   output_filename => $site->config->{sass}{sass_output} . $1 . '.css'
    # });

    # $site->add_object($css_file);
  }

  $site->INFO("* Compiled sass files successfully!");
}

__PACKAGE__->meta->make_immutable;
1;
