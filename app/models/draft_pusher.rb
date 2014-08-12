class DraftPusher
  def initialize(league, player, selection)
    @league = league
    @player = player
    @selection = selection
  end

  def make_selection
    send_to_all_users
    update_team
  end

  private

  attr_reader :league, :player, :selection

  def update_team
    user_id = selection[:selector_id]
    Pusher[user_id].trigger("update_team", {
      name: player.name,
      position: player.position
    })
  end

  def send_to_all_users
    league.users.each do |user|
      Pusher[user.id].trigger("new_selection", selection)
    end
  end
end
