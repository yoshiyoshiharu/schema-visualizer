# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :require_login

  private

  def require_login
    return if current_user.present?

    redirect_to new_sessions_path
  end
end
