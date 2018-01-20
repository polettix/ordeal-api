package WebService::Ordeal;
use Mojo::Base 'Mojolicious';
use Log::Any::Adapter;
use Log::Any qw< $log >;

# This method will run once at server start
sub startup {
   my $self = shift;

   $self->moniker($ENV{MONIKER} || 'ordeal');
   Log::Any::Adapter->set('MojoLog', logger => $self->app->log);
   my $config = $self->plugin('JSONConfig');

   $self->secrets(
      [split m{\s+}mxs, $config->{secrets} || $ENV{SECRETS} || 'wh4t3v3r']
   );
   $log->warning($config->{secrets});

   # Documentation browser under "/perldoc"
   $self->plugin('PODRenderer');
   $self->plugin(
      "OpenAPI" => {url => $self->home->rel_file("openapi-2.0.json")});

   # Router
   my $r = $self->routes;
} ## end sub startup

1;
