require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "active_job/railtie"
# require "active_storage/engine"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RoscosmosProbes
  class Application < Rails::Application
    config.load_defaults 6.1

    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource(
          '*',
          headers: :any,
          methods: %i[get patch put delete post options]
        )
      end
    end

    config.time_zone = 'Brasilia'
    config.i18n.available_locales = ['pt-BR']
    config.i18n.default_locale = :'pt-BR'
  end
end
