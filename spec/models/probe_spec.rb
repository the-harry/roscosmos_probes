# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Probe, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_numericality_of(:x) }
    it { is_expected.to validate_numericality_of(:y) }
    it do
      is_expected.to validate_inclusion_of(:direction)
        .in_array(described_class::DIRECTIONS)
    end
  end
end
