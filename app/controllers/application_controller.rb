# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :error404

  def error404
    render json: { error: '404 error' }, status: :not_found
  end
end
