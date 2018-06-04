require_relative 'boot'

require 'rails/all'

require_relative 'rails_env'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Stackoverflow
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.active_job.queue_adapter = :sidekiq

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_spec: false,
                       routing_spec: false,
                       request_spec: false,
                       controller_spec: true
      g.fixture_replacment :factory_bot, dir: 'spec/factories'
    end

    # Load defaults from config/*.env in config
    Dotenv.load *Dir.glob(Rails.root.join("config/**/*.env"), File::FNM_DOTMATCH)

    # Override any existing variables if an environment-specific file exists
    Dotenv.overload *Dir.glob(Rails.root.join("config/**/*.env.#{Rails.env}"), File::FNM_DOTMATCH)

    config.after_initialize do
      Rails.application.credentials.env = RailsEnv.new
    end
  end
end
