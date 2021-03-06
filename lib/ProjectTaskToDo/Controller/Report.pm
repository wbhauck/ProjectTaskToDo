package ProjectTaskToDo::Controller::Report;

use Moose;
# use the time functions
use POSIX qw/strftime/;
use namespace::autoclean;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Report - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut





=head2 project_time_by_person_by_date

=cut

sub project_time_by_ :
  Path('project_time_for_person_for_date_range') : Args(0) {
    my ( $self, $c ) = @_;

    #grab params

    # get user_id and remove any non-digits
    my $user_id = $c->request->params->{user_id};
    $user_id =~ s/[^[:digit:]]//g;

    # get the start and end dates and make sure in form yyyy-mm-dd
    my $start_date = $c->request->params->{start_date};
    $start_date =~ s/[^[:digit:]\-]//g;
    my $end_date = $c->request->params->{end_date};
    $end_date =~ s/[^[:digit:]\-]//g;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'reports';
    $c->stash->{pagetitle} = 'Reports: Time By Person By Date';

    # build the query's where clause
    my %where_clause = ();
    if ($user_id) {
        $where_clause{task_comment_user_id} = { '=' => $user_id };
    }
    $where_clause{task_comment_date_of_work} =
      { -between => [ $start_date, $end_date ] };

    my $times_for_person = $c->model('ProjectTaskToDoDB::TaskComment')->search(
        { %where_clause },
        {
            join   => {qw/task project comment_creator/},
            select => [
                'comment_creator.full_name',
                'task_comment_user_id',
                'task_comment_date_of_work',
                'task_comment_task_id',
                'task.task_project_id',
                'project.project_name',
                'project.project_short_name',
                { sum => 'task_comment_time_worked' }
            ],
            as => [
                'full_name',                 'task_comment_user_id',
                'task_comment_date_of_work', 'task_comment_task_id',
                'task_project_id',           'project_name',
                'project_short_name',        'time_sum'
            ],
            group_by => [
                'task_comment_user_id', 'task_comment_date_of_work',
                'task_project_id'
            ],
            order_by => ['task_comment_date_of_work'],

        }
    );

    my %person_time = ();
    my $total_time  = 0;

    while ( my $row = $times_for_person->next ) {
        if ( $row->get_column('time_sum') > 0 ) {
            $person_time{ $row->comment_creator->id }
              { $row->task_comment_date_of_work }
              { $row->task->task_project_id } = {
                task_comment_user_id => $row->task_comment_user_id,
                user_full_name       => $row->comment_creator->full_name,
                task_name            => $row->task->task_name,
                project_short_name   => $row->get_column('project_short_name'),
                project_name         => $row->get_column('project_name'),
                time_by_project_by_date => $row->get_column('time_sum')
              };
            $total_time = $total_time + $row->get_column('time_sum');
        }
    }

    # $c->stash->{person_time} = \$times_for_person;
    $c->stash->{person_time} = \%person_time;
    $c->stash->{total_time}  = $total_time;

    $c->stash->{template} = 'report/project_time_for_person_for_date_range.tt';

}


=head2 project_time_by_person_by_date

=cut

sub project_time_for_person_for_date_range :
  Path('project_time_for_person_for_date_range') : Args(0) {
    my ( $self, $c ) = @_;

    #grab params

    # get user_id and remove any non-digits
    my $user_id = $c->request->params->{user_id};
    $user_id =~ s/[^[:digit:]]//g;

    # get the start and end dates and make sure in form yyyy-mm-dd
    my $start_date = $c->request->params->{start_date};
    $start_date =~ s/[^[:digit:]\-]//g;

    $c->stash->{start_date} = $start_date;

    my $end_date = $c->request->params->{end_date};
    $end_date =~ s/[^[:digit:]\-]//g;

    $c->stash->{end_date} = $end_date;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'reports';
    $c->stash->{pagetitle} = 'Reports: Time By Person By Date';

    # build the query's where clause
    my %where_clause = ();
    if ($user_id) {
        $where_clause{task_comment_user_id} = { '=' => $user_id };
    }
    
    # not deleted tasks
    $where_clause{task_status_type_id} = { '!=' => '3' };

    $where_clause{task_comment_date_of_work} =
      { -between => [ $start_date, $end_date ] };

    my $times_for_person = $c->model('ProjectTaskToDoDB::TaskComment')->search(
        { %where_clause },
        {
            join   => {qw/task project comment_creator/},
            select => [
                'comment_creator.full_name',
                'task_comment_user_id',
                'task_comment_date_of_work',
                'task_comment_task_id',
                'task.task_project_id',
                'project.project_name',
                'project.project_short_name',
                { sum => 'task_comment_time_worked' }
            ],
            as => [
                'full_name',                 'task_comment_user_id',
                'task_comment_date_of_work', 'task_comment_task_id',
                'task_project_id',           'project_name',
                'project_short_name',        'time_sum'
            ],
            group_by => [
                'task_comment_user_id', 'task_comment_date_of_work',
                'task_project_id'
            ],
            order_by => ['task_comment_date_of_work'],

        }
    );

    my %person_time = ();
    my $total_time  = 0;

    while ( my $row = $times_for_person->next ) {
        if ( $row->get_column('time_sum') > 0 ) {
            $person_time{ $row->comment_creator->id }
              { $row->task_comment_date_of_work }
              { $row->task->task_project_id } = {
                task_comment_user_id => $row->task_comment_user_id,
                user_full_name       => $row->comment_creator->full_name,
                task_name            => $row->task->task_name,
                project_short_name   => $row->get_column('project_short_name'),
                project_name         => $row->get_column('project_name'),
                time_by_project_by_date => $row->get_column('time_sum')
              };
            $total_time = $total_time + $row->get_column('time_sum');
        }
    }

    # $c->stash->{person_time} = \$times_for_person;
    $c->stash->{person_time} = \%person_time;
    $c->stash->{total_time}  = $total_time;

    $c->stash->{template} = 'report/project_time_for_person_for_date_range.tt';

}

=head2 task_time_by_person_by_date

=cut

sub task_time_for_person_for_date_range :
  Path('task_time_for_person_for_date_range') : Args(0) {
    my ( $self, $c ) = @_;

    #grab params

    # get user_id and remove any non-digits
    my $username = $c->request->params->{username};

    #get the project_short_name if any
    my $project_short_name = $c->request->params->{project_short_name};

    #$user_id =~ s/[^[:digit:]]//g;
    $username =~ s/[^\w]//g;

    # get the start and end dates and make sure in form yyyy-mm-dd
    my $start_date = $c->request->params->{start_date};
    $start_date =~ s/[^[:digit:]\-]//g;
    my $end_date = $c->request->params->{end_date};
    $end_date =~ s/[^[:digit:]\-]//g;

    # stash the start_date & end_date to be displayed on page
    $c->stash->{start_date} = $start_date;
    $c->stash->{end_date}   = $end_date;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'reports';
    $c->stash->{pagetitle} = 'Reports: Time By Person By Date';

#	select user.full_name as Person, project.project_name as Project, task.task_name as Task, project_short_name as JobCode, sum(task_comment_time_worked) div 60 as Hour, sum(task_comment_time_worked) mod 60 as Min, task_comment_date_of_work as Date, dayname(task_comment_date_of_work) as Day
#	from project, task, task_comment, user
#	where
#	task_comment.task_comment_date_of_work >= date_add(curdate(), interval -(dayofweek(curdate())) day)
#	and user.id=1
#	and project.project_id = task.task_project_id
#	and task.task_id=task_comment_task_id
#	and task_comment_user_id=user.id
#	group by task_comment_user_id, task_comment_date_of_work, task_project_id
#	order by user.full_name, task_comment.task_comment_date_of_work;

    # build the query's where clause
    my %where_clause = ();

    if ($username) {
        my $user_instance =
          $c->model('ProjectTaskToDoDB::User')->find( { username => $username } );
        my $user_id = $user_instance->id;
        $where_clause{task_comment_user_id} = { '=' => $user_id };
    }
	if ($project_short_name)
	{
		$where_clause{project_short_name } = { '=' => $project_short_name }
	}
    $where_clause{task_comment_date_of_work} =
      { -between => [ $start_date, $end_date ] };

      # not deleted tasks
    $where_clause{task_status_type_id } =
      { "!=" => '3' };

    my $times_for_person = $c->model('ProjectTaskToDoDB::TaskComment')->search(
        { %where_clause },
        {
            join   => {qw/task project comment_creator/},
            select => [
                'comment_creator.full_name',
                'task_comment_user_id',
                'task_comment_date_of_work',
                'task_comment_task_id',
                'task.task_project_id',
                'project.project_name',
                'project.project_short_name',
                { sum => 'task_comment_time_worked' }
            ],
            as => [
                'full_name',                 'task_comment_user_id',
                'task_comment_date_of_work', 'task_comment_task_id',
                'task_project_id',           'project_name',
                'project_short_name',        'time_sum'
            ],
            group_by => [
                'task_comment_user_id', 'task_comment_date_of_work',
                'task_comment_task_id'
            ],
            order_by => ['task_comment_date_of_work'],

        }
    );

    my %person_time = ();
    my $total_time  = 0;

    while ( my $row = $times_for_person->next ) {
        if ( $row->get_column('time_sum') > 0 ) {
            $person_time{ $row->comment_creator->id }
              { $row->task_comment_date_of_work }{ $row->task->task_project_id }
              { $row->task_comment_task_id } = {
                task_comment_user_id => $row->task_comment_user_id,
                user_full_name       => $row->comment_creator->full_name,
                task_name            => $row->task->task_name,
                project_short_name   => $row->get_column('project_short_name'),
                project_name         => $row->get_column('project_name'),
                time_by_project_by_date => $row->get_column('time_sum')
              };
            $total_time = $total_time + $row->get_column('time_sum');
        }
    }

    # $c->stash->{person_time} = \$times_for_person;
    $c->stash->{person_time} = \%person_time;
    $c->stash->{total_time}  = $total_time;

    $c->stash->{template} = 'report/task_time_for_person_for_date_range.tt';

}

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{cur_date} = strftime "%Y-%m-%d", localtime();
    $c->stash->{users} = [ $c->model('ProjectTaskToDoDB::User')->search( {}, { order_by => 'full_name' } ) ];
    $c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->search({ status_id => { '!=' => 3 } }, {order_by => 'project_short_name' })];
}







=head1 AUTHOR

William B. Hauck

=cut

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
