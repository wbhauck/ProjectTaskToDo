package ProjectTaskToDo::Model::ProjectTaskToDoDB;

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


use strict;
#use the time functions
use POSIX qw/strftime/;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'ProjectTaskToDo::Schema',
    
    connect_info => {
        dsn => 'dbi:mysql:projecttasktodo',
        user => 'projecttasktodo',
        password => 'projecttasktodo',
    }
);





#grab the current date
my $cur_date = strftime "%Y-%m-%d", localtime();




sub my_inactive_todolists {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args= shift;
			my $cur_user_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT project.project_id, project.project_name, project.project_short_name, project.project_sched_start_date, project.project_actual_start_date
				FROM project
				LEFT JOIN project_user
				ON project.project_id = project_user.project_user_project_id
				WHERE
				project.project_alive = 0
				AND project.status_id = 2
				AND project.list_type = 2
				AND project_user.project_user_user_id = $cur_user_id
				AND project.deleted <> 'y'
				ORDER BY project.project_name
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref({project_id => 1, project_name => 1, project_short_name => 2, project_sched_start_date => 3, project_actual_start_date => 4})};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}






sub total_project_time {
	my $self = shift;

	my $project_id = shift;
	#print "project_id=$project_id\n";
	
	$project_id = 0 unless $project_id;
	#print "project_id=$project_id\n";
	
	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args = shift;
			my $project_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT sum(task_comment.task_comment_time_worked) div 60, sum(task_comment.task_comment_time_worked) mod 60
				FROM task_comment, task
				WHERE task_comment.task_comment_task_id = task.task_id
				AND task.task_project_id = $project_id; 
			");

			$sth->execute();
			#my @rows = @{$sth->fetchall_arrayref({total_time => 1})};
			#print "rows = @rows\n";
			my @rows = @{$sth->fetchall_arrayref()};
			#return map { $_->[0] } @rows;
		},
	$project_id);
}



sub my_active_todolists {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args= shift;
			my $cur_user_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT project.project_id, project.project_name, project.project_short_name, project.project_sched_start_date, project.project_actual_start_date
				FROM project
				LEFT JOIN project_user
				ON project.project_id = project_user.project_user_project_id
				WHERE
				project.project_alive = 1
				AND project.list_type = 2
				AND project_user.project_user_user_id = $cur_user_id
				ORDER BY project.project_short_name
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref({project_id => 1, project_name => 1, project_short_name => 2, project_sched_start_date => 3, project_actual_start_date => 4})};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}


sub my_active_tasks {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args= shift;
			my $cur_user_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT *
				FROM task 
				LEFT JOIN task_user
				ON project.project_id = project_user.project_user_project_id
				WHERE
				project.project_alive = 1
				AND project_user.project_user_user_id = $cur_user_id
				ORDER BY project.project_name
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref({project_id => 1, project_name => 1, project_short_name => 2, project_sched_start_date => 3, project_actual_start_date => 4})};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}


sub num_my_late_tasks {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

	my @extra_args= shift;
	my $cur_user_id = $extra_args[0];
	
	#my $cur_user_id = shift;

	#print "inner loop: cur_user_id=$cur_user_id\n";
		
			#grab the current user
			my $sth = $dbh->prepare("
			SELECT count(task.task_id)
			FROM project
			LEFT JOIN task
			ON task.task_project_id = project.project_id
			WHERE
			task.task_complete <> 'y'
			AND task.deleted <> 'y'
			AND task.task_owner_id = $cur_user_id
			AND task.task_sched_start_date < $cur_date
			#AND task.task_sched_start_date <> 0000-00-00
			AND project.project_complete <> 'y'
			AND project.deleted <> 'y'
			AND 
				(task.task_actual_start_date is null
				OR
				task.task_actual_start_date = '0000-00-00')
",);


			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref()};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}



######################################
# FIX ME: REMOVE 2010-02-01
sub my_active_projects {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args= shift;
			my $cur_user_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT project.project_id, project.project_name, project.project_short_name, project.project_sched_start_date, project.project_actual_start_date, project.project_owner_id
				FROM project
				LEFT JOIN project_user
				ON project.project_id = project_user.project_user_project_id
				WHERE
				project.project_alive = 1
				AND project.list_type = 1
				AND project_user.project_user_user_id = $cur_user_id
				ORDER BY project.project_short_name
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref({project_id => 0, project_name => 1, project_short_name => 2, project_sched_start_date => 3, project_actual_start_date => 4, project_owner_id => 5})};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}
######################################


sub my_inactive_projects {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args= shift;
			my $cur_user_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT DISTINCT project.project_id, project.project_name, project.project_short_name, project.project_sched_start_date, project.project_actual_start_date, project.project_sched_compl_date, project.project_actual_compl_date
				FROM project
				LEFT JOIN project_user
				ON project.project_id = project_user.project_user_project_id
				WHERE
				project.project_alive = 0
				AND project.status_id = 2
				AND project.list_type = 1
				AND project_user.project_user_user_id = $cur_user_id
				AND project.deleted <> 'y'
				ORDER BY project.project_name
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref({project_id => 1, project_name => 1, project_short_name => 2, project_sched_start_date => 3, project_actual_start_date => 4, project_sched_compl_date => 5, project_actual_compl_date => 6})};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}


######################################


sub all_inactive_projects {
	my $self = shift;

	my $cur_user_id = shift;
	#print "cur_user_id=$cur_user_id\n";
	
	$cur_user_id = 0 unless $cur_user_id;
	#print "cur_user_id=$cur_user_id\n";
	
	my @cur_user_array=($cur_user_id);
	#print "cur_user_array=@cur_user_array\n";

	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args= shift;
			my $cur_user_id = $extra_args[0];
	
		
			my $sth = $dbh->prepare("
				SELECT project.project_id, project.project_name, project.project_short_name, project.project_sched_start_date, project.project_actual_start_date
				FROM project
				WHERE
				project.project_alive = 0
				AND project.status_id = 2
				AND project.list_type = 1
				AND project.deleted <> 'y'
				ORDER BY project.project_short_name
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref({project_id => 1, project_name => 1, project_short_name => 2, project_sched_start_date => 3, project_actual_start_date => 4})};
			#return map { $_->[0] } @rows;
		},
	$cur_user_id);
}

######################################


sub total_task_time {
	my $self = shift;
	my $task_id = shift;
	
	$task_id = 0 unless $task_id;
	
	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my $self = shift;
			my $dbh = shift;

			my @extra_args = shift;
			my $task_id = $extra_args[0];

			my $sth = $dbh->prepare("
				SELECT sum(task_comment.task_comment_time_worked)
				FROM task_comment
				WHERE
				task_comment.task_comment_task_id = $task_id 
			");

			$sth->execute();
			my @rows = @{$sth->fetchall_arrayref()};
		},
	$task_id);
}




=head1 NAME

ProjectTaskToDo::Model::ProjectTaskToDoDB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<ProjectTaskToDo>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<ProjectTaskToDo::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.48

=head1 AUTHOR

William B. Hauck

=cut

1;
