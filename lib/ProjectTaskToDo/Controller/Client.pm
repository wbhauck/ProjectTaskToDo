package ProjectTaskToDo::Controller::Client;

use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Client - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut












=head2 client_name_lookup

=cut

sub client_name_lookup : Local {
	my ($self, $c) = @_;
	my @results = ();
	my $cname= $c->req->query_parameters->{term};

	my $clients = $c->model('ProjectTaskToDoDB::Person')->search ( {
			full_name => { -like => "\%$cname\%" },
			active => { '=' => 1 }
	       	} );

	while (my $cur_client = $clients->next) {
		# my $label = $cur_client->full_name . " (" . $cur_client->office_email . ")";
		my $label = $cur_client->full_name ;
		push (@results, { id => $cur_client->full_name, label => $label, value => $cur_client->id } );
	}
	$c->stash->{json} = \@results;
}


=head2 end

=cut

sub end : Private {
	my ($self, $c) = @_;
	$c->forward('View::JSON');
}








=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Client in Client.');
}


=head1 AUTHOR

William B. Hauck

=head1 COPYRIGHT

Copyright (C) 2008 - 2015 William B. Hauck, http://wbhauck.com

=head1 LICENSE

This file is part of ProjectTaskToDo.

ProjectTaskToDo is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ProjectTaskToDo is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with ProjectTaskToDo.  If not, see <http://www.gnu.org/licenses/>.

=cut

__PACKAGE__->meta->make_immutable;

1;
