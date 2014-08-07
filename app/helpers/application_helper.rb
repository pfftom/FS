module ApplicationHelper
  def paginate_table(group, group_id)
    escape_javascript(paginate(group, remote: true, param_name: group_id).to_s)
  end

  def render_table(group)
    escape_javascript render(partial: "player", collection: group, as: :player)
  end
end
