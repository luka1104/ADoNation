class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_pvs = ProjectPv.where(user_id: params[:id]).count
    @user_donated = @user_pvs * 5
    @donated_today = ProjectPv.where(created_date: Date.today).count
  end

  # logger.debug("[warn] users/registrations#new")
  # logger.info("[error] users/registrations#new")
  # logger.warn("[warn] users/registrations#new")
  # logger.error("[error] users/registrations#new")
  # logger.fatal("[fatal] users/registrations#new")

end
