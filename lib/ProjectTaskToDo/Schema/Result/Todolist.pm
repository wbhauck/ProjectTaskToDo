package ProjectTaskToDo::Schema::Result::Todolist;

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

ProjectTaskToDo::Schema::Result::Todolist

=cut

__PACKAGE__->table("todolist");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 short_name

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 creator_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 owner_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 requirements_text

  data_type: 'longtext'
  is_nullable: 1

=head2 requirements_document

  data_type: 'longblob'
  is_nullable: 1

=head2 sched_start_date

  data_type: 'date'
  is_nullable: 1

=head2 actual_start_date

  data_type: 'date'
  is_nullable: 1

=head2 start_date_diff

  data_type: 'integer'
  is_nullable: 1

=head2 sched_compl_date

  data_type: 'date'
  is_nullable: 1

=head2 actual_compl_date

  data_type: 'date'
  is_nullable: 1

=head2 compl_date_diff

  data_type: 'integer'
  is_nullable: 1

=head2 complete

  data_type: 'char'
  default_value: 'n'
  is_nullable: 0
  size: 1

=head2 completion_notes

  data_type: 'text'
  is_nullable: 1

=head2 deleted

  data_type: 'char'
  default_value: 'n'
  is_nullable: 0
  size: 1

=head2 deletion_date

  data_type: 'date'
  is_nullable: 1

=head2 last_modified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 modified_by_user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 deletion_notes

  data_type: 'text'
  is_nullable: 1

=head2 recorded

  data_type: 'datetime'
  is_nullable: 1

=head2 alive

  data_type: 'char'
  default_value: 1
  is_nullable: 0
  size: 1

=head2 alive_modified

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "short_name",
  { data_type => "char", is_nullable => 1, size => 16 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "creator_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "owner_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "requirements_text",
  { data_type => "longtext", is_nullable => 1 },
  "requirements_document",
  { data_type => "longblob", is_nullable => 1 },
  "sched_start_date",
  { data_type => "date", is_nullable => 1 },
  "actual_start_date",
  { data_type => "date", is_nullable => 1 },
  "start_date_diff",
  { data_type => "integer", is_nullable => 1 },
  "sched_compl_date",
  { data_type => "date", is_nullable => 1 },
  "actual_compl_date",
  { data_type => "date", is_nullable => 1 },
  "compl_date_diff",
  { data_type => "integer", is_nullable => 1 },
  "complete",
  { data_type => "char", default_value => "n", is_nullable => 0, size => 1 },
  "completion_notes",
  { data_type => "text", is_nullable => 1 },
  "deleted",
  { data_type => "char", default_value => "n", is_nullable => 0, size => 1 },
  "deletion_date",
  { data_type => "date", is_nullable => 1 },
  "last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "modified_by_user_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "deletion_notes",
  { data_type => "text", is_nullable => 1 },
  "recorded",
  { data_type => "datetime", is_nullable => 1 },
  "alive",
  { data_type => "char", default_value => 1, is_nullable => 0, size => 1 },
  "alive_modified",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/FE0HpqveRH8f/eeY9rwhA


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
