# frozen_string_literal: true

FactoryBot.define do
  factory :probe do
    name { 'Sputnik 2' }
    cosmonaut { 'Laika' }
    x { 0 }
    y { 0 }
    direction { 'D' }
  end
end
