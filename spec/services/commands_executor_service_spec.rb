# frozen_string_literal: true

require 'rails_helper'

describe CommandsExecutorService do
  describe '.call' do
    let(:probe) { create(:probe, x: 0, y: 0) }

    subject { described_class.call(probe, commands) }

    context 'when it succeeds' do
      let(:commands) { %w[GE M M M GD M M] }

      before do
        subject
        probe.reload
      end

      it 'updates the probe coordinates' do
        expect(probe.current_position).to eq({ x: 3, y: 2, direction: 'D' })
      end
    end

    context 'when it fails' do
      let(:commands) { %w[GD M M] }

      it 'raises a transaction error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)

        probe.reload

        expect(probe.current_position).to eq({ x: 0, y: 0, direction: 'D' })
      end
    end
  end
end
