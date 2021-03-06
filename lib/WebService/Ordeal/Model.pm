package WebService::Ordeal::Model;
use Mojo::Base qw< -base -signatures >;
use Mojo::SQLite;
has 'dbh';
sub create ($package, $app) {
   my $self = $package->new(dbh => Mojo::SQLite->new());
}

sub card_get ($self, $id) {}
sub card_insert ($self, $data) {}
sub card_list ($self, $filter) {}
sub card_remove ($self, $id) {}
sub card_update ($self, $id) {}

1;
