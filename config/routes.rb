# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resource :probe, only: %i[create] do
        post '/travel_home', to: 'probes#travel_home'
      end
    end
  end
end
