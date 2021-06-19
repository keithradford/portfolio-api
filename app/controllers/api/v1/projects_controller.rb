module Api
  module V1
    class ProjectsController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: [:create, :destroy]

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

      def authenticate_user
        # Authorization: Bearer <token>
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end

      def project_params
        params.require(:project).permit(:title, :description, :caption)
      end
    end
  end
end