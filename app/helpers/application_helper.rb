module ApplicationHelper
  def controller_name_action_name(join_with: ' ')
    [controller_name, action_name].join(join_with)
  end
end
