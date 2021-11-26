# frozen_string_literal: true

class Probe < ApplicationRecord
  DIRECTIONS = %w[E D C B].freeze

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :x, numericality: { greater_than_or_equal_to: 0 }
  validates :y, numericality: { greater_than_or_equal_to: 0 }
  validates :direction, inclusion: { in: DIRECTIONS }

  def travel_home!
    update!(x: 0, y: 0, direction: 'C')
  end
end
