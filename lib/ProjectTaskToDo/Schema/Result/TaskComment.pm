package ProjectTaskToDo::Schema::Result::TaskComment;

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

ProjectTaskToDo::Schema::Result::TaskComment

=cut

__PACKAGE__->table("task_comment");

=head1 ACCESSORS

=head2 task_comment_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 task_comment_task_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 task_comment_user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 task_comment_type_id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 task_comment_date_of_work

  data_type: 'date'
  is_nullable: 1

=head2 task_comment_time_worked

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 task_comment_body

  data_type: 'longtext'
  is_nullable: 1

=head2 task_comment_recorded

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 billable

  data_type: 'char'
  default_value: 0
  is_nullable: 0
  size: 1

=cut

__PACKAGE__->add_columns(
  "task_comment_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "task_comment_task_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "task_comment_user_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "task_comment_type_id",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "task_comment_date_of_work",
  { data_type => "date", is_nullable => 1 },
  "task_comment_time_worked",
  { data_type => "float", extra => { unsigned => 1 }, is_nullable => 1 },
  "task_comment_body",
  { data_type => "longtext", is_nullable => 1 },
  "task_comment_recorded",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "billable",
  { data_type => "char", default_value => 0, is_nullable => 0, size => 1 },
);
__PACKAGE__->set_primary_key("task_comment_id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bLfxf1IN/McDkcbIz27cAw


__PACKAGE__->add_columns(
	task_comment_recorded => { data_type => 'datetime', inflate_datetime => 0 },
	task_comment_date_of_work => { data_type => 'date', inflate_datetime => 0 },
);


__PACKAGE__->belongs_to('comment_creator' => 'ProjectTaskToDo::Schema::Result::User', 'task_comment_user_id');
__PACKAGE__->belongs_to('task' => 'ProjectTaskToDo::Schema::Result::Task', 'task_comment_task_id');
__PACKAGE__->belongs_to('is_type' => 'ProjectTaskToDo::Schema::Result::TaskCommentType', 'task_comment_type_id');



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
