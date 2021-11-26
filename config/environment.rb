# frozen_string_literal: true

require_relative 'application'

Rails.application.configure do
  config.hosts << ENV.fetch('DNS_NAME') { /web/ }

  logger = ActiveSupport::Logger.new($stdout)
  logger.formatter = Dclog::Formatter.new
  config.logger    = ActiveSupport::TaggedLogging.new(logger)

  level            = ENV.fetch('LOG_LEVEL', 'info')
  config.log_level = Rails.env.test? ? :warn : level.underscore.to_sym

  config.logger.formatter.add_silencer { |line| line =~ /\/favicon\.ico/ }

  config.log_tags = [:request_id]
end

Rails.application.initialize!
