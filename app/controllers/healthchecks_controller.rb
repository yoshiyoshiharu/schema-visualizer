# frozen_string_literal: true

class HealthchecksController < ApplicationController
  skip_before_action :require_login

  def show
    ApplicationRecord.connection.execute('SELECT 1;')
    render plain: 'ok'
  end
end
