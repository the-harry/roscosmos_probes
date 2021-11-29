# frozen_string_literal: true

class Probe < ApplicationRecord
  DIRECTIONS = %w[E D C B].freeze
  DIRECTIONS_MAPPING = {
    e: { ge: 'B', gd: 'C' },
    d: { ge: 'C', gd: 'B' },
    c: { ge: 'E', gd: 'D' },
    b: { ge: 'D', gd: 'E' }
  }.freeze
  MOVEMENTS_MAPPING = {
    e: Proc.new { |x, y| [x, (y - 1)] },
    d: Proc.new { |x, y| [x, (y + 1)] },
    c: Proc.new { |x, y| [(x + 1), y] },
    b: Proc.new { |x, y| [(x - 1), y] }
  }.freeze

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :x, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :x, numericality: { less_than_or_equal_to: 4, only_integer: true }
  validates :y, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :y, numericality: { less_than_or_equal_to: 4, only_integer: true }
  validates :direction, inclusion: { in: DIRECTIONS }

  after_commit :update_gps_location, on: :update

  def travel_home!
    update!(x: 0, y: 0, direction: 'D')
  end

  def move!
    new_x, new_y = MOVEMENTS_MAPPING[direction.downcase.to_sym].call(x, y)

    update!(x: new_x, y: new_y)
  end

  def change_direction!(command)
    update!(
      direction: DIRECTIONS_MAPPING.dig(
        direction.downcase.to_sym, command.downcase.to_sym
      )
    )
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
