# frozen_string_literal: true

class CommandsExecutorService < BaseService
  def call(probe, commands)
    ActiveRecord::Base.transaction do
      commands.map do |command|
        probe.move! if command == 'M'
        probe.change_direction!(command) unless command == 'M'
        probe.reload
      end
    end

    probe
  end
end
