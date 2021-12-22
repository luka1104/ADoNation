module AdminHelper
  def show_status(status)
    if status == false
      status = "no-active"
    else
      status = "active"
    end
    return status
  end
end
