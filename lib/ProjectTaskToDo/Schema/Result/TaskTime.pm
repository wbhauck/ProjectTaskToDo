package ProjectTaskToDo::Schema::Result::TaskTime;

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

ProjectTaskToDo::Schema::Result::TaskTime

=cut

__PACKAGE__->table("task_time");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 comment_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 task_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 recorded_at

  data_type: 'datetime'
  is_nullable: 1

=head2 recorded_by

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 modified_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 modified_by

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 date_of_work

  data_type: 'date'
  is_nullable: 0

=head2 time_worked

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "comment_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "task_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "recorded_at",
  { data_type => "datetime", is_nullable => 1 },
  "recorded_by",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "modified_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "modified_by",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "date_of_work",
  { data_type => "date", is_nullable => 0 },
  "time_worked",
  { data_type => "float", extra => { unsigned => 1 }, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nlsXNG/1R7OIfUKcXmwzAw


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
