module Api
  module V1
    class TasksController < BaseController
      def index
        tasks = Task.includes(:project, :task_attachments).order(created_at: :desc)

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
  end
end
