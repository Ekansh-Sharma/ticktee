class ProjectsController < ApplicationController
	before_action :authorize_admin!, except: [:index, :show]
	before_action :set_project, only: [:edit,:update,:destroy,:show]

	def index
		@projects = Project.all
	end
	def new
		@project = Project.new
	end

	def edit
	end

	def update
		if @project.update(project_params)
			flash[:notice] = "Project has been updated."
			redirect_to @project
		else
			flash[:alert] = "Project has not been updated."
			render 'edit'
		end

	end

	def destroy
		if @project.destroy
			flash[:notice] = "Project has been destroyed."
		else
			flash[:alert] = "Project has not been destroyed."
		end
		redirect_to projects_path
	end

	def create
		@project = Project.new(project_params)
		if @project.save
			flash[:notice] = "Project has been created."
			redirect_to project_path(@project)
		else
			flash[:alert] = "Project has not been created."
			render "new"
		end
	end

	def show
	end

	private
	def set_project
		begin
			@project = Project.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The project you were looking"+" for could not be found."
			redirect_to projects_path
		end
	end
	def project_params
		params.require(:project).permit(:name,:description)
	end
end
