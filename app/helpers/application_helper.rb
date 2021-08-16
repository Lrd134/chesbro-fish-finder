module ApplicationHelper

  def allowed_to_modify?(model)
    model.user_id == current_user.id || current_user.is_admin?
  end
end
