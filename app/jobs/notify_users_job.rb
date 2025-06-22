class NotifyUsersJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    TaskNotificationMailer
      .with(task: task)
      .new_task_email
      .deliver_now
  end
end
