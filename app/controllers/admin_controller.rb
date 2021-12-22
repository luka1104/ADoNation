class AdminController < ApplicationController
  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def active
    project = Project.find(params[:id])
    project.update(status: 1)
    redirect_to admin_index_path
  end
end
