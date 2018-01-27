package WebService::Ordeal::Model;
use Mojo::Base -base, -signatures;
use Mojo::SQLite;

has 'db';

sub create ($package, $app) {
   my $self = $package->new(db => Mojo::SQLite->new());
}

1;
