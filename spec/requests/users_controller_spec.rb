# frozen_string_literal: true

RSpec.describe UsersController do
  include LoginSupport

  before do
    login_as(create(:login_user, is_admin:))
  end

  describe '#index' do
    subject do
      get users_path
      response
    end

    context '管理者権限がある場合' do
      let(:is_admin) { true }

      it { is_expected.to have_http_status(:ok) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#new' do
    subject do
      get new_user_path
      response
    end

    context '管理者権限がある場合' do
      let(:is_admin) { true }

      it { is_expected.to have_http_status(:ok) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#create' do
    subject do
      post(users_path, params:)
      response
    end

    let(:params) { { user: { name:, email: } } }

    context '管理者権限があり、正常な値を送信した場合' do
      let(:is_admin) { true }
      let(:name) { 'new_user' }
      let(:email) { 'new_user@test.com' }

      it { is_expected.to redirect_to(users_path) }
    end

    context '管理者権限があり、不正な値を送信した場合' do
      let(:is_admin) { true }
      let(:name) { '' }
      let(:email) { '' }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }
      let(:name) { 'new_user' }
      let(:email) { 'new_user@test.com' }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#edit' do
    subject do
      get edit_user_path(user)
      response
    end

    let(:user) { create(:user) }

    context '管理者権限がある場合' do
      let(:is_admin) { true }

      it { is_expected.to have_http_status(:ok) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#update' do
    subject do
      put(user_path(user), params:)
      response
    end

    let(:user) { create(:user) }
    let(:params) { { user: { email: } } }

    context '管理者権限があり、正常な値を送信した場合' do
      let(:is_admin) { true }
      let(:email) { 'updated_user@test.com' }

      it { is_expected.to redirect_to(users_path) }
    end

    context '管理者権限があり、不正な値を送信した場合' do
      let(:is_admin) { true }
      let(:email) { '' }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }
      let(:email) { 'updated_user@test.com' }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#destroy' do
    subject do
      delete user_path(user)
      response
    end

    let(:user) { create(:user) }

    context '管理者権限がある場合' do
      let(:is_admin) { true }

      it { is_expected.to redirect_to(users_path) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }

      it { is_expected.to redirect_to(root_path) }
    end
  end
end
