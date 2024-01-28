# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :require_login

  unless Rails.env.development?
    rescue_from Exception,                      with: :render500
    rescue_from ActiveRecord::RecordNotFound,   with: :render404
    rescue_from ActionController::RoutingError, with: :render404
  end

  def raise_routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def render404
    render 'errors/404', status: :not_found, layout: 'without_sidebar'
  end

  def render500
    render 'errors/500', status: :internal_server_error, layout: 'without_sidebar'
  end

  def require_login
    return if current_user.present?

    redirect_to new_sessions_path
  end
end
