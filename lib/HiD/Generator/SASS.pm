package HiD::Generator::SASS;

# ABSTRACT: transform SASS files to CSS 

=head1 DESCRIPTION

=cut

use Moose;
with 'HiD::Generator';

use 5.014;

use HiD::VirtualPage;

=method generate

=cut

sub generate {
  my( $self , $site ) = @_;

  die "WAHAT";

  my $css_page = HiD::VirtualPage->new({
    content         => "it's a start",
    output_filename => $site->destination . '/bogus.css' ,
  });

  $site->add_object( $css_page );

  $site->INFO( "* Transformed SASS files");
}


__PACKAGE__->meta->make_immutable;
1;
