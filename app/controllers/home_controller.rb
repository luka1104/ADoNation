class HomeController < ApplicationController
  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def contact
  end

  def aboutus
  end

  def terms
  end

  def privacy
  end
end
