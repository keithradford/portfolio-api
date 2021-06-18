module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        render json: Project.all
      end

      def create
        project = Project.new(project_params)

        if project.save
          render json: project, status: :created
        else
          render json: project.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Project.find(params[:id]).destroy!

        head :no_content
      end

      private

      def project_params
        params.require(:project).permit(:title, :description, :caption)
      end
    end
  end
end