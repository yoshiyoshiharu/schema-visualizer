class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error404

  def error404
    render json: { error: '404 error' }, status: 404
  end
end
