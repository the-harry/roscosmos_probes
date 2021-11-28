# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProbeChannel, type: :channel do
  let(:probe) { create(:probe) }

  before do
    stub_connection({ probe_id: probe.id, coordinates: '1_1', face: '/\\' })

    subscribe({ probe_id: probe.id, coordinates: '1_1', face: '/\\' })
  end

  context 'When it subscribes' do
    it 'subscribes successfully' do
      expect(subscription).to be_confirmed
    end

    it 'has the event id as identifier' do
      expect(subscription.probe_id).to eq(probe.id)
    end

    it 'has the probe coordinates as identifier' do
      expect(subscription.coordinates).to eq('1_1')
    end

    it 'has the probe face as identifier' do
      expect(subscription.face).to eq('/\\')
    end
  end

  context 'When it unsubscribes' do
    it 'stop the stream' do
      unsubscribe

      expect(subscription).not_to have_streams
    end
  end
end
