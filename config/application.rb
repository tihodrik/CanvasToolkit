require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TemplateProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.time_zone = 'Moscow'
    config.active_record.default_timezone = :utc

    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths << "#{Rails.root}/app/lib"
    config.autoload_paths << "#{Rails.root}/app/importers"
    config.autoload_paths << "#{Rails.root}/app/import_requests"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
