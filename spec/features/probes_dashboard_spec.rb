# frozen_string_literal: true

require 'rails_helper'

describe 'DashboardsController' do
  describe '#index' do
    context 'when no probe has been shipped yet' do
      before { visit root_path }

      it 'show the default message' do
        expect(page.body).to have_content('No probe launched yet...')
      end
    end

    context 'when some probe is in orbit' do
      let!(:probe) { create(:probe) }

      before { visit root_path }

      it 'show the name of the probe' do
        expect(page.body).to have_content(probe.name)
      end

      it 'show the details link' do
        expect(page.body).to have_link('View GPS details')
      end
    end
  end

  describe '#show' do
    context 'it tracks GPS position' do
      let!(:probe) { create(:probe, x: 1, y: 1, direction: 'C') }

      before do
        visit root_path
        click_on 'View GPS details'
      end

      it 'have probe id as data attribute' do
        expect(page.body).to include(probe.id)
      end

      it 'have probe position as data attribute' do
        expect(page.body).to include('1_1')
      end

      it 'have probe face as data attribute' do
        expect(page.body).to include(probe.face)
      end

      it 'show the name of the probe' do
        expect(page.body).to have_content(probe.name)
      end

      it 'show the name of the cosmonaut' do
        expect(page.body).to have_content(probe.cosmonaut)
      end

      it 'show the probe X position' do
        expect(page.body).to have_content(probe.x)
      end

      it 'show the probe Y position' do
        expect(page.body).to have_content(probe.y)
      end

      it 'show the probe direction' do
        expect(page.body).to have_content(probe.direction)
      end
    end
  end
end
