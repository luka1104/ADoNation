class HomeController < ApplicationController
  def index
    @projects = Project.all.order(created_at: :desc)
  end
end
