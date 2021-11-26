# frozen_string_literal: true

class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid,
              ActiveRecord::NotNullViolation do |error|
    Dclog.error("ERROR: #{error}")

    render json: { message: error.message }, status: :unprocessable_entity
  end
end
