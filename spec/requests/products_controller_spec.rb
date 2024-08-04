# frozen_string_literal: true

RSpec.describe ProductsController do
  include LoginSupport

  before do
    login_as(create(:login_user, is_admin:))
  end

  describe '#index' do
    subject do
      get products_path
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
      get new_product_path
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
      post(products_path, params:)
      response
    end

    let(:params) { { product: { name: } } }

    context '管理者権限があり、正常な値を送信した場合' do
      let(:is_admin) { true }
      let(:name) { 'new_product' }

      it { is_expected.to redirect_to(products_path) }
    end

    context '管理者権限があり、不正な値を送信した場合' do
      let(:is_admin) { true }
      let(:name) { '' }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }
      let(:name) { 'new_product' }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#edit' do
    subject do
      get edit_product_path(product)
      response
    end

    let(:product) { create(:product) }

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
      put(product_path(product), params:)
      response
    end

    let(:product) { create(:product) }
    let(:params) { { product: { name: } } }

    context '管理者権限があり、正常な値を送信した場合' do
      let(:is_admin) { true }
      let(:name) { 'Updated Product' }

      it { is_expected.to redirect_to(products_path) }
    end

    context '管理者権限があり、不正な値を送信した場合' do
      let(:is_admin) { true }
      let(:name) { '' }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }
      let(:name) { 'Updated Product' }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe '#destroy' do
    subject do
      delete product_path(product)
      response
    end

    let(:product) { create(:product) }

    context '管理者権限がある場合' do
      let(:is_admin) { true }

      it { is_expected.to redirect_to(products_path) }
    end

    context '管理者権限がない場合' do
      let(:is_admin) { false }

      it { is_expected.to redirect_to(root_path) }
    end
  end
end
