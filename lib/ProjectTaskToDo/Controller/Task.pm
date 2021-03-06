package ProjectTaskToDo::Controller::Task;

use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Task - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut










=head2 my_complete

=cut

sub my_complete : Local {
    my ( $self, $c ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'complete_tasks';
    $c->stash->{pagetitle} = 'My Complete Tasks';

    my $user_id = $c->user->id;
    my $cur_date = strftime "%Y-%m-%d", localtime();

    my $my_projects = $c->model('ProjectTaskToDoDB::Project')->search(
        {
            'deleted'        => { '<>' => 'y' },
            'project_alive ' => { '='  => '1' }
        }
    );

    my @complete_tasks = $my_projects->search_related(
        'tasks',
        {
            'task_owner_id' => $user_id,
            'task_alive'    => { '=' => '0' },
            'tasks.deleted'  => { '<>' => 'y' },
            'task_complete' => { '<>' => 'y' }
        },
        { order_by => 'task_priority' }
    );

    $c->stash->{num_tasks} = $#complete_tasks + 1;
    $c->stash->{tasks}     = \@complete_tasks;

    $c->stash->{template} = 'task/complete.tt';
}



=head2 task_object

=cut

sub task_object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $task_id ) = @_;
    my $task=
      $c->stash->{task_rs}->find( { task_id => $task_id } );
    if ( !$task ) {
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }
    $c->stash( task => $task );


}

=head2 base

=cut

sub base : Chained('/') : PathPart('task') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( task_rs => $c->model('ProjectTaskToDoDB::Task') );
}


=head2 create_new_tasks

=cut

# sub create_new_tasks : Local {
sub create_new_tasks : Chained('/project/project_object') : PathPart('create_new_tasks') : Args(0) {
    my ( $self, $c ) = @_;

    my $project    = $c->stash->{project};
    my $project_id = $project->project_id;

#    # show the details if $c->user is a project user
#    if ( $c->user_exists ) {
#        if (   ( $project->has_user( $c->user ) )
#            || ( $c->check_user_roles('member') ) )
#        {
#            if (   ( $project->project_owner_id == $c->user->id )

    my $cur_user_id = '';

    #grab the user's id for convenience
    if ( $c->user_exists() ) {
        $cur_user_id = $c->user->id;
    }

    if ($project_id) {
        my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $project_id } );

        if ($project) {

            # show the details if $c->user is a project user
            if ( $c->user_exists ) {
                if (   ( $project->has_user( $c->user ) )
                    || ( $c->check_user_roles('member') ) )
                {

                    # tell the template which tab to highlight and the page title
                    $c->stash->{whichtab}  = 'create_new_tasks';
                    $c->stash->{pagetitle} = 'Create Multiple Tasks';

                    $c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->search( { project_id => $project_id } ) ];
                    $c->stash->{template} = 'task/create_new_tasks.tt';
                    $c->stash->{project_users} =
                      [ $c->model('ProjectTaskToDoDB::ProjectUser')->search( { project_user_project_id => $project_id } ) ];

                    #$c->stash->{users} = [$c->model('ProjectTaskToDoDB::User')->all];
                }
            }
            else {
                $c->flash->{message} = "You are not authorized to work with that Project. Please choose another.";
                $c->response->redirect( $c->uri_for("/task/new_task") );
            }
        }
        else {
            $c->flash->{message} = "That Project does not seem to exist.";
            $c->response->redirect( $c->uri_for("/project/active") );
        }
    }
    else {
        my $projects = [ $c->model('ProjectTaskToDoDB')->my_active_projects($cur_user_id) ];

        if (@$projects) {
            $c->stash->{projects}      = $projects;
            $c->stash->{users}         = [ $c->model('ProjectTaskToDoDB::User')->all ];
            $c->stash->{task_statuses} = [ $c->model('ProjectTaskToDoDB::TaskStatusType')->all ];
            $c->stash->{template}      = 'task/create_new_tasks.tt';
        }
        else {
            $c->flash->{message} = "Please create a Project First.";
            $c->response->redirect( $c->uri_for("/project/new_project") );
        }
    }

}

=head2 my_active

=cut

sub my_active : Local {
    my ( $self, $c ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'active_tasks';
    $c->stash->{pagetitle} = 'My Active Tasks';

    my $user_id = $c->user->id;
    my $cur_date = strftime "%Y-%m-%d", localtime();

    my $my_projects = $c->model('ProjectTaskToDoDB::Project')->search(
        {
            'me.deleted'        => { '<>' => 'y' },
            'project_alive ' => { '='  => '1' }
        }
    );

    my @active_tasks = $my_projects->search_related(
        'tasks',
        {
            'task_owner_id' => $user_id,
            'task_alive'    => { '=' => '1' },
            'tasks.deleted'  => { '<>' => 'y' },
            'task_complete' => { '<>' => 'y' }
        },
        { order_by => 'task_priority' }
    );

    $c->stash->{num_tasks} = $#active_tasks + 1;
    $c->stash->{tasks}     = \@active_tasks;

    $c->stash->{template} = 'task/active.tt';
}

=head2 complete

=cut

sub complete : Local {
    my ( $self, $c ) = @_;

    my $cur_date = strftime "%Y-%m-%d", localtime();
    my $alive = 0;

    #grab the task_id and check if the user is authorized to update the task
    my $task_id = $c->req->params->{task_id};
    my $task = $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $task_id } );

    if (
        ( $c->request->method eq 'POST' )
        && (   ( $task->task_owner_id == $c->user->id )
            || ( $task->project->project_owner_id == $c->user->id )
	    || ( $c->check_user_roles('member')
	   )
        )
      ) 
    {

        my $task_statuses = $c->model('ProjectTaskToDoDB::TaskStatusType')->search();


        my $actual_compl_date = $task->task_actual_compl_date;
        if ( ( !$actual_compl_date ) || ( $actual_compl_date eq '0000-00-00' ) ) {
            $actual_compl_date = $cur_date;
        }

        my $actual_start_date = $task->task_actual_start_date;
        if ( ( !$actual_start_date ) || ( $actual_start_date eq '0000-00-00' ) ) {
            $actual_start_date = $actual_compl_date;
        }


        my $task = $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $task_id } );
        my $project_id = $task->task_project_id;

        $task->update(
            {
                task_status_type_id           => '7',
                task_alive               => '0',
                task_actual_start_date   => $actual_start_date,
                task_actual_compl_date   => $actual_compl_date,
                task_modified_by_user_id => $c->user->id,
                task_complete            => 'y',
            }
        );

        # create a notification for each project user
        my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $project_id } );

        for my $pu ( $project->project_users ) {

            $c->model('ProjectTaskToDoDB::Notification')->create(
                {
                    user_to_notify           => $pu->user->id,
                    user_making_modification => $c->user->id,
                    notification_type        => 3,
                    task_id                  => $task_id,
                    body                     => 'Marked Complete'
                }
            );
        }

    }
    else {
        $c->flash->{message} = "You are not authorized to edit this task.";
        $c->response->redirect( $c->uri_for("/task/$task_id") );
    }

    $c->stash->{task} = $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $task_id } );
    $c->stash->{num_comments} = $c->model('ProjectTaskToDoDB::TaskComment')->search(
        { task_comment_task_id => $task_id },
        {
            select => [ { count => 'task_comment_task_id' } ],
            as     => ['count']
        }
    );
    $c->response->redirect( $c->uri_for("/task/$task_id/comments") );
    $c->detach();
}

=head2 details

=cut

sub details : Chained('task_object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my $task            = $c->stash->{task};
    my $task_id = $task->id;
    my $task_project_id = $task->task_project_id;
    my $project         = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $task_project_id } );

    my $authorized = 0;
    $c->stash->{task} = $task;
    if (   ( $task->task_owner_id == $c->user->id )
        || ( $task->project->project_owner_id == $c->user->id )
        || ( $task->project->project_creator_id == $c->user->id ) )
    {
        $c->stash->{authorized} = 1;
    }

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('member') ) )
        {
            $c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->all ];
            my @t_time = $c->model('ProjectTaskToDoDB')->total_task_time($task_id);
            $c->stash->{total_task_time} = $t_time[0];

            $c->stash->{num_comments} = $c->model('ProjectTaskToDoDB::TaskComment')->search(
                { task_comment_task_id => $task_id },
                {
                    select => [ { count => 'task_comment_task_id' } ],
                    as     => ['count']
                }
            );
            $c->stash->{template} = 'task/details.tt';

            ###############
            # calculate the total time for this task
            my $time_rs = $c->model('ProjectTaskToDoDB::TaskComment')->search(
                { task_comment_task_id => $task->task_id },
                {
                    select => [ { sum => 'task_comment_time_worked' } ],
                    as     => [qw/time_sum/],
                }
            );

            my $task_time = undef;

            my $row = $time_rs->first;
            if ( $row->get_column('time_sum') > 0 ) {
                $task_time = $row->get_column('time_sum');
            }
            else {
                $task_time = 0;
            }
            $c->stash->{task_time} = $task_time;
            ###############
        }
    }
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that task.";
        $c->response->redirect( $c->uri_for("/") );
    }

}

=head2 edit

=cut

sub edit : Chained('task_object') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    my $task = $c->stash->{task};
    my $task_id = $task->id;
    my $cur_user_id = $c->user->id;

    if (   ( $task->task_owner_id == $c->user->id )
        || ( $task->project->project_owner_id == $c->user->id )
        || ( $task->project->project_creator_id == $c->user->id ) )
    {
        $c->stash->{task}          = $task;
        $c->stash->{authorized}    = 1;
        $c->stash->{task_statuses} = [ $c->model('ProjectTaskToDoDB::TaskStatusType')->search->all() ];
        $c->stash->{projects}      = [ $c->model('ProjectTaskToDoDB')->my_active_projects($cur_user_id) ];

        $c->stash->{project_users} =
          [ $c->model('ProjectTaskToDoDB::ProjectUser')->search( { project_user_project_id => $task->task_project_id } ) ];
        $c->stash->{template} = 'task/edit.tt';
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this task.";
        $c->response->redirect( $c->uri_for("/task/$task_id") );
    }
}


=head2 insert_comment

=cut

sub insert_comment : Chained('task_object') : PathPart('insert_comment') : Args(0) {
    my ( $self, $c ) = @_;
    my $task = $c->stash->{task};
    my $task_id = $task->id;

    my $creator_id = $c->user->id;

    my $billable = $c->req->params->{billable};
    $billable = 0 unless $billable;
    my $type         = $c->req->params->{type};
    my $date_of_work = $c->req->params->{date_of_work};
    if ( ( !$date_of_work ) || ( $date_of_work eq "today" ) ) {

        #default to current date
        $date_of_work = strftime "%Y-%m-%d", localtime();
    }
    my $time_worked_hours   = $c->req->params->{time_worked_hours};
    my $time_worked_minutes = $c->req->params->{time_worked_minutes};
    my $time_worked         = ( $time_worked_hours * 60 ) + $time_worked_minutes;
    my $comment             = $c->req->params->{comment};


    my $tc                  = $c->model('ProjectTaskToDoDB::TaskComment')->create(
        {
            task_comment_id           => '',
            task_comment_task_id      => $task_id,
            task_comment_user_id      => $creator_id,
            task_comment_type_id      => $type,
            task_comment_date_of_work => $date_of_work,
            task_comment_time_worked  => $time_worked,
            task_comment_body         => $comment,
            billable                  => $billable,
        }
    );

    $c->stash->{tasks}        = [ $c->model('ProjectTaskToDoDB::Task')->search( task_id => $task_id ) ];
    $c->stash->{projects}     = [ $c->model('ProjectTaskToDoDB::Project')->all ];
    $c->stash->{num_comments} = $c->model('ProjectTaskToDoDB::TaskComment')->search(
        { task_comment_id => $task_id },
        {
            select => [ { count => 'task_comment_id' } ],
            as     => ['count']
        }
    );

    # create a notification for each project user
    my $project = $task->project;

    for my $pu ( $project->project_users ) {
        $c->model('ProjectTaskToDoDB::Notification')->create(
            {
                user_to_notify           => $pu->user->id,
                user_making_modification => $c->user->id,
                notification_type        => 4,
                task_id                  => $task_id,
                body                     => $comment
            }
        );
    }

    $c->response->redirect( $c->uri_for("/task/$task_id/comments") );
    $c->detach();
}

=head2 insert_task

=cut

sub insert_task : Local {
    my ( $self, $c ) = @_;
    my $creator_id = $c->user->id;
    my $cur_date   = strftime "%Y-%m-%d", localtime();
    my $now        = strftime "%Y-%m-%d %H:%M:%S", localtime();
    my $name       = $c->req->params->{name};

    if ( !$name ) {
        $c->flash->{message} =
          "You need to enter a Task Name.<br />Use your browser's Back button to continue the Task Creation.";
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();
    }

    my $priority = $c->req->params->{priority};
    my $owner_id = '';
    $owner_id = $c->req->params->{owner_id};
    $owner_id = $creator_id unless $owner_id;
    my $project_id       = $c->req->params->{project_id};
    my $on_project_plan = $c->req->params->{on_project_plan};
    $on_project_plan =~ s/[^01]/0/g;
    $on_project_plan = 0 unless $on_project_plan;

    my $description      = $c->req->params->{description};
    my $sched_start_date = $c->req->params->{sched_start_date};
    if ( lc($sched_start_date) eq "today" ) {
        $sched_start_date = $cur_date;
    }
    my $actual_start_date = $c->req->params->{actual_start_date};
    if ( lc($actual_start_date) eq "today" ) {
        $actual_start_date = $cur_date;
    }
    my $sched_compl_date = $c->req->params->{sched_compl_date};
    if ( lc($sched_compl_date) eq "today" ) {
        $sched_compl_date = $cur_date;
    }
    my $actual_compl_date = $c->req->params->{actual_compl_date};
    if ( lc($actual_compl_date) eq "today" ) {
        $actual_compl_date = $cur_date;
    }
    my $duration = $c->req->params->{duration};
    my $complete = $c->req->params->{complete};
    $complete = 'n' unless $complete;
            my $time_estimate = $c->req->params->{time_estimate_hours} * 60;
            $time_estimate = $time_estimate + $c->req->params->{time_estimate_minutes};
    my $completion_notes = $c->req->params->{completion_notes};

    if ( $complete eq 'y' ) {
        if ( ( !$actual_start_date ) || ( $actual_start_date eq '0000-00-00' ) ) {

            #default to current date
            $actual_start_date = strftime "%Y-%m-%d", localtime();
        }
        if ( ( !$actual_compl_date ) || ( $actual_compl_date eq '0000-00-00' ) ) {

            #default to current date
            $actual_compl_date = strftime "%Y-%m-%d", localtime();
        }
    }

    if ( $actual_start_date && $actual_compl_date ) {
        my $flag = Date_Cmp( $actual_compl_date, $actual_start_date );
        if ( $flag < 0 ) {
            $c->flash->{message} =
"The Completion Date must be equal to or later than the Start Date.<br />Use your browser's Back button to continue the Task Update.";
            $c->response->redirect( $c->uri_for("/") );
            $c->detach();
        }
    }

    my $task = $c->model('ProjectTaskToDoDB::Task')->create(
        {
            task_name                => $name,
            task_priority            => $priority,
            task_creator_id          => $creator_id,
            task_owner_id            => $owner_id,
            task_project_id          => $project_id,
            on_project_plan          => $on_project_plan,
            description         => $description,
            task_sched_start_date    => $sched_start_date,
            task_actual_start_date   => $actual_start_date,
            task_sched_compl_date    => $sched_compl_date,
            task_actual_compl_date   => $actual_compl_date,
            task_duration            => $duration,
            task_recorded            => $now,
            task_modified_by_user_id => $creator_id,
            task_complete            => $complete,
            task_completion_notes    => $completion_notes,
                    time_estimate => $time_estimate
        }
    );

    my $task_id = $task->task_id;


    # if part of a project create a notification for each project user
    if ($project_id)
    {
        my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $project_id } );
    
        for my $pu ( $project->project_users ) {
            $c->model('ProjectTaskToDoDB::Notification')->create(
                {
                    user_to_notify           => $pu->user->id,
                    user_making_modification => $c->user->id,
                    notification_type        => 3,
                    task_id                  => $task_id,
                    body                     => $description
                }
            );
        }
    }

    $c->response->redirect( $c->uri_for("/task/$task_id") );
    $c->detach();
}

=head2 my_living

=cut

sub my_living : Local {
    my ( $self, $c ) = @_;
    my $my_living_tasks = '';
    my $cur_date = strftime "%Y-%m-%d", localtime();

    $c->stash->{tasks} = [
        $c->model('ProjectTaskToDoDB::Task')->search(
            {
                owner_id => $c->user->id,
                deleted  => { '<>' => 'y' },
                complete         => { '<>' => 'y' },
                sched_start_date => { '<=' => $cur_date },
                sched_start_date => { '<>' => '0000-00-00' }
            },
            { order_by => 'priority' }
        )
    ];

    $c->stash->{num_tasks} = $c->model('ProjectTaskToDoDB::Task')->search(
        {
            owner_id => $c->user->id,
            complete => { '<>' => 'y' },
            deleted  => { '<>' => 'y' }
        },
        {
            select => [ { count => 'task_id' } ],
            as     => ['count']
        }
    );
    $c->stash->{template} = 'task/active.tt';
}

=head2 new_comment

=cut

sub new_comment : Chained('task_object') : PathPart('new_comment') : Args(0) {
    my ( $self, $c ) = @_;
    my $task = $c->stash->{task};
    my $task_id = $task->id;

    # allow commenting if $c->user is a project user
#    if ( $project->has_user( $c->user ) ) {
#        if (   ( $project->project_owner_id == $c->user->id )
#            || ( $project->project_creator_id == $c->user->id ) )
#        {
#            $c->stash->{authorized} = 1;
#        }
#        $c->stash->{project}      = $project;

    # my $project = $c->stash->{project};
    # my $project_id = $project->project_id;

    # show the form if $c->user is a project user
    #if ($project->has_user($c->user)) {

    $c->stash->{task}          = $task;
    $c->stash->{comment_types} = [ $c->model('ProjectTaskToDoDB::TaskCommentType')->all ];
    # $c->stash->{tid}           = $task_id;
    $c->stash->{template}      = 'task/new_comment.tt';
}

=head2 new_task

=cut

sub new_task : Local {
    my ( $self, $c, $project_id ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'create_new_task';
    $c->stash->{pagetitle} = 'Create New Task';

    my $cur_user_id = '';

    #grab the user's id for convenience
    if ( $c->user_exists ) {
        $cur_user_id = $c->user->id;
    }

    if ($project_id) {
        my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $project_id } );

        # show the details if $c->user is a project user
        if ( $c->user_exists ) {
            if (   ( $project->has_user( $c->user ) )
                || ( $c->check_user_roles('member') ) )
            {

                $c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->search( { project_id => $project_id } ) ];
                $c->stash->{template} = 'task/new_task.tt';
                $c->stash->{project_users} =
                  [ $c->model('ProjectTaskToDoDB::ProjectUser')->search( { project_user_project_id => $project_id } ) ];

                #$c->stash->{users} = [$c->model('ProjectTaskToDoDB::User')->all];
            }
            else {
                $c->flash->{message} = "You are not authorized to work with that Project. Please choose another.";
                $c->response->redirect( $c->uri_for("/task/new_task") );
            }
        }
    }
    else {
        my $projects = [ $c->model('ProjectTaskToDoDB')->my_active_projects($cur_user_id) ];

        if (@$projects) {
            $c->stash->{projects}      = $projects;
            $c->stash->{users}         = [ $c->model('ProjectTaskToDoDB::User')->all ];
            $c->stash->{task_statuses} = [ $c->model('ProjectTaskToDoDB::TaskStatusType')->all ];
            $c->stash->{template}      = 'task/new_task.tt';
        }
        else {
            $c->flash->{message} = "Please create a Project First.";
            $c->response->redirect( $c->uri_for("/project/new_project") );
        }
    }

}

=head2 pick_date 

=cut

sub pick_date : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'task/pick_date.tt';
}

=head2 search

=cut

sub search : Local {
    my ( $self, $c ) = @_;
    my $c_user_id       = $c->user->id;
    my $criteria        = "";
    my $active_complete = "";
    $criteria             = $c->req->params->{criteria};
    $active_complete      = $c->req->params->{active_complete};
    $c->stash->{criteria} = $criteria;
    if ($criteria) {
        $c->stash->{tasks} = [
            $c->model('ProjectTaskToDoDB::Task')->search_literal(
                "match (task_name, description) against (?) and deleted <> 'y'",
                $criteria
            )
        ];
    }
    $c->stash->{template} = 'task/search.tt';
}

=head2 tasks_for_date

=cut

sub tasks_for_date : Local {
    my ( $self, $c ) = @_;
    my $user_id = $c->user->id;
    my $date    = $c->req->params->{date};
    $c->stash->{tasks} = [
        $c->model('ProjectTaskToDoDB::Task')->search_literal(
"(task_owner_id='$user_id' and deleted <> 'y' and task_complete <> 'y' and task_sched_start_date='$date') or (task_owner_id='$user_id' and deleted <> 'y' and task_complete <> 'y' and task_sched_compl_date='$date')
		"
        )
    ];

    #$c->stash->{tasks}=[$c->model('ProjectTaskToDoDB::Task')->search({
    #complete => 'n',
    #sched_start_date => { '<=' => 'now', '<>' => '0000-00-00' }
    #sched_start_date => { '<=' => 'now' },
    #sched_start_date => { '<>' => '0000-00-00' }
    #})];
    $c->stash->{username}    = $c->user->username;
    $c->stash->{user_id}     = $user_id;
    $c->stash->{date_picked} = $date;
    $c->stash->{projects}    = [ $c->model('ProjectTaskToDoDB::Project')->all ];
    $c->stash->{template}    = 'task/tasks_for_date.tt';
}

=head2 task_with_comments

=cut

sub comments : Chained('task_object') : PathPart('comments') : Args(0) {
    my ( $self, $c ) = @_;
    my $task            = $c->stash->{task};
    my $task_id = $task->id;
    my $task_project_id = $task->task_project_id;
    my $project         = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $task_project_id } );
    my $authorized      = 0;
    my $date_today      = strftime "%Y-%m-%d", localtime();

    # show the details if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('member') ) )
        {

            ###############
            # calculate the total time for this task
            my $time_rs = $c->model('ProjectTaskToDoDB::TaskComment')->search(
                { task_comment_task_id => $task->task_id },
                {
                    select => [ { sum => 'task_comment_time_worked' } ],
                    as     => [qw/time_sum/],
                }
            );

            my $task_time = undef;

            my $row = $time_rs->first;
            if ( $row->get_column('time_sum') > 0 ) {
                $task_time = $row->get_column('time_sum');
            }
            else {
                $task_time = 0;
            }
            $c->stash->{task_time} = $task_time;
            ###############

            if (   ( $task->task_owner_id == $c->user->id )
                || ( $task->project->project_owner_id == $c->user->id )
                || ( $task->project->project_creator_id == $c->user->id ) )
            {
                $c->stash->{authorized} = 1;
            }
            $c->stash->{task}     = $task;
            $c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->all ];
            $c->stash->{comments} =
              [ $c->model('ProjectTaskToDoDB::TaskComment')
                  ->search( { task_comment_task_id => $task_id }, { order_by => 'task_comment_recorded desc' } ) ];
            $c->stash->{template} = 'task/comments.tt';
        }
	}
    else {

        # $c->user is not a project user
        $c->flash->{message} = "You are not authorized to view that task.";
        $c->response->redirect( $c->uri_for("/") );
    }
}

=head2 today

=cut

sub today : Local {
    my ( $self, $c, $project_to_display ) = @_;
    my $user_id = '';
    $project_to_display = $c->req->params->{'project_to_display'}
      unless $project_to_display;
    my $cur_date = strftime "%Y-%m-%d", localtime();

    $user_id = $c->user->id;
    $c->stash->{user_id} = $user_id;

    if ($project_to_display) {
        $c->stash->{tasks} = [
            $c->model('ProjectTaskToDoDB::Task')->search(
                {
                    task_alive    => { '='  => '1' },
                    task_owner_id   => $user_id,
                    task_project_id => $project_to_display,
                    deleted    => { '<>' => 'y' },
                    task_complete   => { '<>' => 'y' },
		-or => [
                	task_sched_start_date => { '<=' => $cur_date, '<>' => '0000-00-00' },
                	task_actual_start_date => { '<=' => $cur_date, '<>' => '0000-00-00' }
		]
                },
                { order_by => [ 'task_sched_start_date', 'task_priority' ] }
            )
        ];
        $c->stash->{username} = $c->user->username;

        $c->stash->{myprojects} = [ $c->model('ProjectTaskToDoDB')->my_active_projects( $c->user->id ) ];
        $c->stash->{template}   = 'task/today.tt';
    }
    else {
        my $my_projects = $c->model('ProjectTaskToDoDB::Project')->search(
            {
                'me.deleted'       => { '<>' => 'y' },
                'project_alive' => { '='  => '1' }
            }
        );

        my @due_tasks = $my_projects->search_related(
            'tasks',
            {
                task_owner_id         => $user_id,
                task_alive            => { '=' => '1' },
                'tasks.deleted'          => { '<>' => 'y' },
                task_complete         => { '<>' => 'y' },
		-or => [
                	task_sched_start_date => { '<=' => $cur_date, '<>' => '0000-00-00' },
                	task_actual_start_date => { '<=' => $cur_date, '<>' => '0000-00-00' }
		]
            },
            { order_by => [ 'task_priority asc', 'task_sched_start_date asc' ] }
        );

        $c->stash->{tasks} = \@due_tasks;

        $c->stash->{cur_date} = $cur_date;
        $c->stash->{username} = $c->user->username;

        $c->stash->{myprojects} = [ $c->model('ProjectTaskToDoDB')->my_active_projects( $c->user->id ) ];
        $c->stash->{template}   = 'task/today.tt';
    }
}

=head2 update

=cut

sub update : Local {
    my ( $self, $c ) = @_;

    my $cur_date = strftime "%Y-%m-%d", localtime();
    my $alive = undef;

    #grab the task_id and check if the user is authorized to update the task
    my $task_id = $c->req->params->{task_id};
    my $task    = $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $task_id } );
    my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $task->task_project_id } );

    my $task_statuses = $c->model('ProjectTaskToDoDB::TaskStatusType')->search();

    # if $c->user is a project user
    if ( $c->user_exists ) {
        if (   ( $project->has_user( $c->user ) )
            || ( $c->check_user_roles('member') ) )
        {
            my $name = $c->req->params->{name};

            if ( !$name ) {
                $c->flash->{message} =
                  "You need to enter a Task Name.<br />Use your browser's Back button to continue the Task Creation.";
                $c->response->redirect( $c->uri_for("/") );
                $c->detach();
            }

            my $status_id = $c->req->params->{status_id};

            #print "STATUS_ID = $status_id\n";
            while ( my $stat = $task_statuses->next ) {
                if ( $status_id == $stat->id ) {
                    $alive = $stat->living;
                }
                last if $alive;
            }

            #print "ALIVE = $alive\n";
            my $project_id       = $c->req->params->{project_id};
            my $owner_id         = $c->req->params->{owner_id};
            my $on_project_plan = $c->req->params->{on_project_plan};
            my $priority         = $c->req->params->{priority};
            my $description      = $c->req->params->{description};
            my $sched_start_date = $c->req->params->{sched_start_date};
            if ( lc($sched_start_date) eq "today" ) {
                $sched_start_date = $cur_date;
            }
            my $actual_start_date = $c->req->params->{actual_start_date};
            if ( lc($actual_start_date) eq "today" ) {
                $actual_start_date = $cur_date;
            }
            my $sched_compl_date = $c->req->params->{sched_compl_date};
            if ( lc($sched_compl_date) eq "today" ) {
                $sched_compl_date = $cur_date;
            }
            my $actual_compl_date = $c->req->params->{actual_compl_date};
            if ( lc($actual_compl_date) eq "today" ) {
                $actual_compl_date = $cur_date;
            }

            my $complete = $c->req->params->{complete};
            if ( $status_id == 2 ) {
                $alive = 0;

                if (   ( !$actual_start_date )
                    || ( $actual_start_date eq '0000-00-00' ) )
                {

                    #check if there's an $actual_compl_date. if so, use it
                    if (   ($actual_compl_date)
                        && ( $actual_compl_date ne '0000-00-00' ) )
                    {
                        $actual_start_date = $actual_compl_date;
                    }
                    else {

                        #default to current date
                        $actual_start_date = strftime "%Y-%m-%d", localtime();
                    }
                }
                if (   ( !$actual_compl_date )
                    || ( $actual_compl_date eq '0000-00-00' ) )
                {

                    #default to current date
                    $actual_compl_date = strftime "%Y-%m-%d", localtime();
                }
            }

            # make sure sched_start_date <= sched_compl_date
            if ( $sched_start_date && $sched_compl_date ) {
                my $flag = Date_Cmp( $sched_compl_date, $sched_start_date );
                if ( $flag < 0 ) {
                    $c->flash->{message} =
"The Scheduled Completion Date must be equal to or later than the Scheduled Start Date.<br />Use your browser's Back button to continue the Task Update.";
                    $c->response->redirect( $c->uri_for("/") );
                    $c->detach();
                }
            }

            # make sure actual_start_date <= actual_compl_date
            if ( $actual_start_date && $actual_compl_date ) {
                my $flag = Date_Cmp( $actual_compl_date, $actual_start_date );
                if ( $flag < 0 ) {
                    $c->flash->{message} =
"The Actual Completion Date must be equal to or later than the Actual Start Date.<br />Use your browser's Back button to continue the Task Update.";
                    $c->response->redirect( $c->uri_for("/") );
                    $c->detach();
                }
            }

            my $duration      = $c->req->params->{duration};

            my $time_estimate = $c->req->params->{time_estimate_hours} * 60;
            $time_estimate = $time_estimate + $c->req->params->{time_estimate_minutes};


            my $deleted       = $c->req->params->{deleted};
            my $deletion_date = $c->req->params->{deletion_date};
            if ($deleted) {
                $alive = 0;

                if ( ( !$deletion_date ) || ( $deletion_date eq '0000-00-00' ) ) {

                    #default to current date
                    $deletion_date = strftime "%Y-%m-%d", localtime();
                }
            }
            my $completion_notes = $c->req->params->{completion_notes};
            my $deletion_notes   = $c->req->params->{deletion_notes};

            my $task = $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $task_id } );

            $task->update(
                {
                    task_name                => $name,
                    task_status_type_id           => $status_id,
                    task_alive               => $alive,
                    task_owner_id            => $owner_id,
                    on_project_plan   => $on_project_plan,
                    task_project_id          => $project_id,
                    task_priority            => $priority,
                    description         => $description,
                    task_sched_start_date    => $sched_start_date,
                    task_actual_start_date   => $actual_start_date,
                    task_sched_compl_date    => $sched_compl_date,
                    task_actual_compl_date   => $actual_compl_date,
                    task_duration            => $duration,
                    task_deletion_date       => $deletion_date,
                    task_modified_by_user_id => $c->user->id,
                    task_complete            => $complete,
                    deleted             => $deleted,
                    task_completion_notes    => $completion_notes,
                    task_deletion_notes      => $deletion_notes,
                    time_estimate => $time_estimate
                }
            );

            # create a notification for each project user
            my $project = $c->model('ProjectTaskToDoDB::Project')->find( { project_id => $project_id } );

            for my $pu ( $project->project_users ) {

                $c->model('ProjectTaskToDoDB::Notification')->create(
                    {
                        user_to_notify           => $pu->user->id,
                        user_making_modification => $c->user->id,
                        notification_type        => 3,
                        task_id                  => $task_id,
                        body                     => $description
                    }
                );
            }
        }
    }
    else {
        $c->flash->{message} = "You are not authorized to edit this task.";
        $c->response->redirect( $c->uri_for("/task/$task_id") );
    }

    $c->stash->{task} = $c->model('ProjectTaskToDoDB::Task')->find( { task_id => $task_id } );
    $c->stash->{num_comments} = $c->model('ProjectTaskToDoDB::TaskComment')->search(
        { task_comment_task_id => $task_id },
        {
            select => [ { count => 'task_comment_task_id' } ],
            as     => ['count']
        }
    );
    $c->response->redirect( $c->uri_for("/task/$task_id/comments") );
    $c->detach();
}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # $c->response->body('Matched ProjectTaskToDo::Controller::Task in Task.');
    $c->detach('/task/active');
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
