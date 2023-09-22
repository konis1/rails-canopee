require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsCanopee
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq

    # config.action_mailer.delivery_method = :smtp
    #   config.action_mailer.smtp_settings = {
    #       :address => "smtp.gmail.com",
    #       :port => 587,
    #       :domain => "gmail.com",
    #       :user_name => "bonnefeuilleparis@gmail.com",
    #       :password => 'GMAIL_PASS',
    #       :authentication => "plain",
    #       :enable_starttls_auto => true
    #   }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
