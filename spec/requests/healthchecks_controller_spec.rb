# frozen_string_literal: true

RSpec.describe HealthchecksController do
  context 'データベースへの接続が正常である場合' do
    before { get '/healthcheck' }

    it { expect(response).to have_http_status(:ok) }

    it { expect(response.body).to eq 'ok' }
  end
end
