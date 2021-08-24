module ApplicationHelper

  def logged_in?
    !session[:uid].nil?
  end
  def whos_logged_in
    session[:uid]
  end
end
