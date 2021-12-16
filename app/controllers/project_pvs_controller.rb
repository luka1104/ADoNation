class ProjectPvsController < ApplicationController
  def create
    if user_signed_in?
      @userid_pv = current_user.id
    else
      @userid_pv = 0
    end
    @ip_address = remote_ip()
    @project_pv = ProjectPv.new(
      user_id: @userid_pv,
      user_ip: @ip_address,
      created_date: Date.today,
      project_id: params[:project_id]
    )
    @project_pv.save
    redirect_to(project_path(id: params[:project_id]))
  end
end
