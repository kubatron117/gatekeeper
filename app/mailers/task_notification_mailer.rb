class TaskNotificationMailer < ApplicationMailer
  def new_task_email
    @task            = params[:task]
    @assigned_user   = @task.user
    @project_name    = @task.project.name

    mail(
      to: @assigned_user.email,
      subject: "New Task: #{@task.subject}"
    )
  end
end
