# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ProbesController', type: :request do
  let(:headers) { { 'Content-Type': 'application/json' } }

  describe 'POST /api/v1/probe' do
    let(:params) do
      {
        name: 'Sputnik 1',
        cosmonaut: 'Harry',
        x: 0,
        y: 0,
        direction: 'C'
      }.to_json
    end

    context 'when the request is valid' do
      it 'returns status code 201' do
        post '/api/v1/probe', params: params, headers: headers

        expect(response).to have_http_status(:created)
      end

      it 'returns the created probe id' do
        post '/api/v1/probe', params: params, headers: headers

        expect(response.body).to match(Probe.last.id)
      end
    end

    context 'when the params is empty' do
      before { post '/api/v1/probe', params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the record exists' do
      let!(:probe) { create(:probe, name: 'Sputnik 1') }

      before { post '/api/v1/probe', params: params, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the coordinates are negative' do
      let(:params) do
        {
          name: 'Sputnik 1',
          cosmonaut: 'Harry',
          x: -1,
          y: -2,
          direction: 'C'
        }.to_json
      end

      before { post '/api/v1/probe', params: params, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST /api/v1/probe/travel_home' do
    let!(:probe) { create(:probe) }

    context 'when the request is valid' do
      let(:params) { { id: probe.id }.to_json }

      it 'returns status code 200' do
        post '/api/v1/probe/travel_home', params: params, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'travels back to home' do
        post '/api/v1/probe/travel_home', params: params, headers: headers

        expect(Probe.last.x).to eq(0)
        expect(Probe.last.y).to eq(0)
        expect(Probe.last.direction).to eq('C')
      end
    end

    context 'when the probe dont exists' do
      let(:params) { { id: 1 }.to_json }

      before do
        post '/api/v1/probe/travel_home', params: params, headers: headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /api/v1/probe/current_position/:ID' do
    context 'when the id is found' do
      let!(:probe) { create(:probe) }

      before do
        get "/api/v1/probe/current_position/#{probe.id}", headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the coordinates' do
        expect(JSON.parse(response.body).values)
          .to contain_exactly(probe.x, probe.y, probe.direction)
      end
    end

    context 'when it fails to find the probe' do
      it 'returns status code 404' do
        get '/api/v1/probe/current_position/foobar', headers: headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
