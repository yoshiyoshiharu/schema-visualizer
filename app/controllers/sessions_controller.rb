# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  layout 'login'

  def new; end

  def create
    if (user = User.find_from_auth_hash(auth_hash))
      log_in user
    else
      flash.now[:danger] = t('.danger')
      return render :new
    end

    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
