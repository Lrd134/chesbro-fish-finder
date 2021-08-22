module ApplicationHelper

  def logged_in?
    !session[:uid].nil?
  end
end
