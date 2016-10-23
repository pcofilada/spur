Facebook::Messenger.configure do |config|
  config.access_token = Rails.application.secrets.fb_access_token
  config.app_secret   = Rails.application.secrets.fb_vapp_secret
  config.verify_token = Rails.application.secrets.fb_verify_token
end

unless Rails.env.production?
	bot_files = Dir[Rails.root.join("app", "bot", "**", "*.rb")]
	bots_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
		bot_files.each{ |file| require_dependency file }
	end
	ActionDispatch::Callbacks.to_prepare do
		bots_reloader.execute_if_updated
	end
	bot_files.each { |file| require_dependency file }
end
