package WebService::Ordeal::Controller::Card;
use Mojo::Base 'Mojolicious::Controller';
use Log::Any qw< $log >;
use Try::Tiny;
use MIME::Base64;
use 5.020002;
use experimental qw< postderef >;
no warnings experimental qw< postderef >;

sub _get {
   my $c = shift->openapi->valid_input or return;
   my $card;
   try {
      $card = $c->app->model->card_get($c->stash('card_id'))
         || $c->render(status => 404, text => 'Not Found');
   }
   catch {
      # FIXME is there anything available from OpenAPI here? FIXME
      $c->render(status => 500, text => 'Cannot perform action');
   };
   return unless $card;
   return ($c, $card);
}

sub _reshape {
   my ($c, $card, $include_data) = @_;
   my %retval;
   $retval{type} = $card->{content_type};
   $retval{guid} = 'FIXME'; # FIXME
   $retval{content_url} = $retval{guid} . '/content';
   $retval{name} = $card->{name} if defined $card->{name};
   if ($include_data) {
      my $ok;
      try {
         open my $fh, '<', $card->{path} or die 'whatever';
         binmode $fh, ':raw' or die 'binmode';
         local $/; # slurp
         my $data = readline($fh) or die 'readline';
         close $fh or die 'close';
         $retval{content} = encode_base64($data);
         $ok = 1;
      }
      catch {
         $log->error("while reading file <$card->{path}>: $_");
         $c->render(status => 500, text => 'Cannot get data');
      };
      return unless $ok;
   }
   return \%retval;
}

sub get {
   my ($c, $card) = _get(shift) return;
   $card = _reshape($c, $card, $c->param('include_data')) or return;
   $c->render(openapi => $card);
}

sub get_data {
   my ($c, $card) = _get(shift) return;
   $c->res->headers->content_type($card->{content_type});
   $c->reply->asset(Mojo::Asset::File->new(path => $card->{path}));
}

sub insert {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
}

sub list {
   my $c = shift->openapi->valid_input or return;
   try {
      my @list = map { _reshape($c, $_) } $c->app->model->card_list()->@*;
      $c->render(openapi => \@list);
   }
   catch {
      $c->render(status => 500, text => 'Cannot perform action');
   };
   return;
}

sub remove {
   my $c = shift->openapi->valid_input or return;
   try {
      $c->app->model->card_remove($c->stash('card_id'));
      $c->render(status => 204);
   }
   catch {
      # FIXME is there anything available from OpenAPI here? FIXME
      $c->render(status => 500, text => 'Cannot perform action');
   };
   return;
}

sub update {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
}

sub upload {
   my $c = shift->openapi->valid_input or return;
   $c->render(openapi => [{content_uri => 'x', guid => 'y', type => ''}]);
}

1;
