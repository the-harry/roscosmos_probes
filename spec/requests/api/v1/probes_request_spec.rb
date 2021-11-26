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
end