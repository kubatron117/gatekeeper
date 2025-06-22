class Api::V1::TasksController < Api::V1::BaseController
  # GET /api/v1/tasks
  def index
    tasks = Task
              .includes(:project, :task_attachments)
              .order(created_at: :desc)

    render json: {
      tasks: tasks.as_json(
        only: [:id, :subject, :description, :status, :created_at, :updated_at],
        include: {
          project: { only: [:id, :name] },
          task_attachments: { only: [:id, :note] }
        }
      )
    }
  end
end
