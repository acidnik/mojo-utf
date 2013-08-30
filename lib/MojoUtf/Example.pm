package MojoUtf::Example;
use Mojo::Base 'Mojolicious::Controller';
use DBI;
# use utf8; # Mojo::Base imports utf8 by default since 3.69

# This action will render a template
sub welcome {
  my $self = shift;

  my $dbh = DBI->connect("DBI:mysql:database=test", '', '', { mysql_enable_utf8 => 1 }); # that works

  $dbh->do("create table if not exists foo (id serial, name varchar(100) not null unique) default charset = utf8");
  $dbh->do("insert ignore into foo (name) values (?)",undef, "великий и могучий");

  my $row = $dbh->selectrow_hashref("select name from foo limit 1");


  # Render template "example/welcome.html.ep" with message
  $self->render(message => $row->{name});
}

1;
