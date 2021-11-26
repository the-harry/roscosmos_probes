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

  describe '#travel_home!' do
    let(:probe) { create(:probe, x: 3, y: 1, direction: 'E') }

    subject { probe.travel_home! }

    it 'resets the probe X position' do
      expect { subject }.to change { probe.reload.x }.from(3).to(0)
    end

    it 'resets the probe Y position' do
      expect { subject }.to change { probe.reload.y }.from(1).to(0)
    end

    it 'resets the probe direction' do
      expect { subject }.to change { probe.reload.direction }.from('E').to('C')
    end
  end
end
