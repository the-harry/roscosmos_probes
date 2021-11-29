# frozen_string_literal: true

class Probe < ApplicationRecord
  DIRECTIONS = %w[E D C B].freeze

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :x, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :x, numericality: { less_than_or_equal_to: 5, only_integer: true }
  validates :y, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :y, numericality: { less_than_or_equal_to: 5, only_integer: true }
  validates :direction, inclusion: { in: DIRECTIONS }

  after_commit :update_gps_location, on: :update

  def travel_home!
    update!(x: 0, y: 0, direction: 'D')
  end

  def current_position
    { x: x, y: y, direction: direction }
  end

  def face
    return '/\\' if direction == 'C'
    return '>' if direction == 'D'
    return '<' if direction == 'E'
    return '\/' if direction == 'B'
  end

  private

  def update_gps_location
    ActionCable.server.broadcast(
      "probe_channel_#{id}",
      { probe_id: id, coordinates: "#{x + 1}_#{y + 1}", face: face }
    )
  end
end
