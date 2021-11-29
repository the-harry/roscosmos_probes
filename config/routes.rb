# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboards#index'
  resource :dashboards, only: %i[show]

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resource :probe, only: %i[create show] do
        get '/current_position/:id', to: 'probes#current_position'
        post '/travel_home', to: 'probes#travel_home'
        post '/run_commands', to: 'probes#run_commands'
      end
    end
  end
end
