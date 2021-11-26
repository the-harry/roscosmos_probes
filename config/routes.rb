# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboards#index'
  resource :dashboards, only: %i[show]

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resource :probe, only: %i[create show] do
        post '/travel_home', to: 'probes#travel_home'
        get '/current_position/:id', to: 'probes#current_position'
      end
    end
  end
end
