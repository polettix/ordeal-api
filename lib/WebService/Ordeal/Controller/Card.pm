package WebService::Ordeal::Controller::Card;
use Mojo::Base 'Mojolicious::Controller';
use Log::Any qw< $log >;

# This action will render a template
sub list {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
} ## end sub list

1;
