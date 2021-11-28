# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/app/channels/application_cable/connection.rb'
  add_filter '/bin'
  add_filter '/config'
  add_filter '/coverage'
  add_filter '/db'
  add_filter '/log'
  add_filter '/tmp'
  add_filter '/public'
  add_filter '/storage'
  add_filter '/vendor'
end

SimpleCov.minimum_coverage 70

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
