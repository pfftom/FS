Pusher.logger = Rails.logger
Pusher.app_id = ENV.fetch("PUSHER_APP_ID")
Pusher.secret = ENV.fetch("PUSHER_SECRET")
Pusher.key = ENV.fetch("PUSHER_KEY")
