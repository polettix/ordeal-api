package WebService::Ordeal::Controller::Deck;
use Mojo::Base 'Mojolicious::Controller';
use Log::Any qw< $log >;

sub insert {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
}

sub list {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
}

sub remove {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
}

1;
