package ProjectTaskToDo::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PK::Auto");

=head1 NAME

ProjectTaskToDo::Schema::Result::Project

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 project_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 category_id

  data_type: 'bigint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 billable

  data_type: 'integer'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 project_short_name

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 project_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 project_creator_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 project_owner_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 project_description

  data_type: 'text'
  is_nullable: 1

=head2 project_requirements_text

  data_type: 'longtext'
  is_nullable: 1

=head2 project_requirements_document

  data_type: 'longblob'
  is_nullable: 1

=head2 project_sched_start_date

  data_type: 'date'
  is_nullable: 1

=head2 project_actual_start_date

  data_type: 'date'
  is_nullable: 1

=head2 project_start_date_diff

  data_type: 'integer'
  is_nullable: 1

=head2 project_sched_compl_date

  data_type: 'date'
  is_nullable: 1

=head2 project_actual_compl_date

  data_type: 'date'
  is_nullable: 1

=head2 project_compl_date_diff

  data_type: 'integer'
  is_nullable: 1

=head2 sched_go_live_date

  data_type: 'date'
  is_nullable: 1

=head2 actual_go_live_date

  data_type: 'date'
  is_nullable: 1

=head2 project_complete

  data_type: 'char'
  default_value: 'n'
  is_nullable: 0
  size: 1

=head2 project_completion_notes

  data_type: 'text'
  is_nullable: 1

=head2 deleted

  data_type: 'char'
  default_value: 'n'
  is_nullable: 0
  size: 1

=head2 project_deletion_date

  data_type: 'date'
  is_nullable: 1

=head2 project_last_modified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 project_modified_by_user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 project_deletion_notes

  data_type: 'text'
  is_nullable: 1

=head2 project_recorded

  data_type: 'datetime'
  is_nullable: 1

=head2 project_alive

  data_type: 'char'
  default_value: 1
  is_nullable: 0
  size: 1

=head2 project_alive_modified

  data_type: 'datetime'
  is_nullable: 1

=head2 list_type

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 client_person_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 client_person_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_person_department

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_person_office_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_person_email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_organization_email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_organization_office_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_organization_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_organization_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 status_id

  data_type: 'smallint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 allocated_hours

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 client_contact_person_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 client_contact_person_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_contact_person_department

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_contact_person_office_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 client_contact_person_email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "project_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "category_id",
  {
    data_type => "bigint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "billable",
  {
    data_type => "integer",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "project_short_name",
  { data_type => "char", is_nullable => 1, size => 16 },
  "project_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "project_creator_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "project_owner_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "project_description",
  { data_type => "text", is_nullable => 1 },
  "project_requirements_text",
  { data_type => "longtext", is_nullable => 1 },
  "project_requirements_document",
  { data_type => "longblob", is_nullable => 1 },
  "project_sched_start_date",
  { data_type => "date", is_nullable => 1 },
  "project_actual_start_date",
  { data_type => "date", is_nullable => 1 },
  "project_start_date_diff",
  { data_type => "integer", is_nullable => 1 },
  "project_sched_compl_date",
  { data_type => "date", is_nullable => 1 },
  "project_actual_compl_date",
  { data_type => "date", is_nullable => 1 },
  "project_compl_date_diff",
  { data_type => "integer", is_nullable => 1 },
  "sched_go_live_date",
  { data_type => "date", is_nullable => 1 },
  "actual_go_live_date",
  { data_type => "date", is_nullable => 1 },
  "project_complete",
  { data_type => "char", default_value => "n", is_nullable => 0, size => 1 },
  "project_completion_notes",
  { data_type => "text", is_nullable => 1 },
  "deleted",
  { data_type => "char", default_value => "n", is_nullable => 0, size => 1 },
  "project_deletion_date",
  { data_type => "date", is_nullable => 1 },
  "project_last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "project_modified_by_user_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "project_deletion_notes",
  { data_type => "text", is_nullable => 1 },
  "project_recorded",
  { data_type => "datetime", is_nullable => 1 },
  "project_alive",
  { data_type => "char", default_value => 1, is_nullable => 0, size => 1 },
  "project_alive_modified",
  { data_type => "datetime", is_nullable => 1 },
  "list_type",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "client_person_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "client_person_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_person_department",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_person_office_phone",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_person_email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_organization_email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_organization_office_phone",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_organization_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_organization_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "status_id",
  {
    data_type => "smallint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "allocated_hours",
  { data_type => "float", extra => { unsigned => 1 }, is_nullable => 1 },
  "client_contact_person_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "client_contact_person_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_contact_person_department",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_contact_person_office_phone",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "client_contact_person_email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("project_id");
__PACKAGE__->add_unique_constraint("project_short_name_unique", ["project_short_name"]);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-05-15 22:48:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TaoZXyaUVoDyjEBvoxGMVQ


__PACKAGE__->add_columns(
        project_recorded => { data_type => 'datetime', inflate_datetime => 0 },
        project_last_modified => { data_type => 'timestamp', inflate_datetime => 0 },
        project_alive_modified => { data_type => 'datetime', inflate_datetime => 0 },
  	project_sched_start_date => { data_type => 'date', inflate_date=> 0 },
  	project_actual_start_date => { data_type => 'date', inflate_date=> 0 },
  	project_sched_compl_date => { data_type => 'date', inflate_date=> 0 },
  	project_actual_compl_date => { data_type => 'date', inflate_date=> 0 },
  	project_deletion_date => { data_type => 'date', inflate_date=> 0 },
  	sched_go_live_date => { data_type => 'date', inflate_date=> 0 },
  	actual_go_live_date => { data_type => 'date', inflate_date=> 0 },

);


__PACKAGE__->has_many('project_users' => 'ProjectTaskToDo::Schema::Result::ProjectUser', 'project_user_project_id');



__PACKAGE__->has_many('files' => 'ProjectTaskToDo::Schema::Result::ProjectFile', { 'foreign.project_id' => 'self.project_id' } );
__PACKAGE__->has_many('notes' => 'ProjectTaskToDo::Schema::Result::Note', { 'foreign.project_id' => 'self.project_id' } );
__PACKAGE__->belongs_to('status' => 'ProjectTaskToDo::Schema::Result::ProjectStatusType', 'status_id');
__PACKAGE__->has_many('tasks' => 'ProjectTaskToDo::Schema::Result::Task', 'task_project_id');
__PACKAGE__->belongs_to('creator' => 'ProjectTaskToDo::Schema::Result::User', 'project_creator_id');
__PACKAGE__->belongs_to('owner' => 'ProjectTaskToDo::Schema::Result::User', 'project_owner_id');
__PACKAGE__->belongs_to('category' => 'ProjectTaskToDo::Schema::Result::ProjectCategory', 'category_id');
__PACKAGE__->has_many('links' => 'ProjectTaskToDo::Schema::Result::ProjectLink', 'project_id');
__PACKAGE__->belongs_to('time_palette' => 'ProjectTaskToDo::Schema::Result::TimePaletteProject', 'project_id');


sub has_user {
  my ($self, $user) = @_;
  return $self->project_users->find({ project_user_user_id => $user->id });
}


sub total_project_time {
  my ($self, $project_id) = @_;

#	SELECT sum(task_comment.task_comment_time_worked) div 60, sum(task_comment.task_comment_time_worked) mod 60
#	FROM task_comment, task
#	WHERE task_comment.task_comment_task_id = task.task_id
#	AND task.task_project_id = $project_id;

  # select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = ?;

  my $users = $self->tasks->find({ task_project_id => $project_id });
  return $users;
}


sub my_active_projects {
	my ($self, $user) = @_;

	my $projects='';
	
	$user = 0 unless $user;
	
#		
#			my $sth = $dbh->prepare("
#				SELECT project.project_id, project.project_name, project.project_short_name, project.project_sched_start_date, project.project_actual_start_date, project.project_owner_id
#				FROM project
#				LEFT JOIN project_user
#				ON project.project_id = project_user.project_user_project_id
#				WHERE
#				project.project_alive = 1
#				AND project.list_type = 1
#				AND project_user.project_user_user_id = $cur_user_id
#				ORDER BY project.project_short_name
#			");

	return $projects;
}



sub time_by_person {
	my ($self, $project_id) = @_;

	my $time = $self->tasks->search( { task_project_id => $project_id })->task_comments->search(
		{},
		{
			select => [ { sum => 'task_comment_time_worked' } ],
			as => ['user_time'],
			group_by => 'task_comment_user_id',
		}
	);
}




#sub total_project_time {
#	my ($self, $project_number) = @_;
#
#	my $project_time = 0;
#
#        my $time_rs = $self->search(
#            { task_project_number => $project_number },
#            {
#                select => [ { sum => 'time_worked' } ],
#                as     => ['project_time']
#            }
#        );
#
#        if ($time_rs->first) {
#            $project_time = $time_rs->first->get_column('project_time');
#        }
#
#	return $project_time;
#}


__PACKAGE__->meta->make_immutable;
1;


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
