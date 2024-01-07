# frozen_string_literal: true

RSpec.describe UsersController do
  include LoginSupport

  before do
    login_as(create(:login_user))
  end

  describe '#index' do
    it 'ステータスコード200を返すこと' do
      get users_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    it 'ステータスコード200を返すこと' do
      get new_user_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context '正常な値を送信したとき' do
      let(:valid_param) do
        {
          user: {
            name: 'New User',
            email: 'new_user@test.com'
          }
        }
      end

      it 'indexにリダイレクトすること' do
        post users_path, params: valid_param
        expect(response).to redirect_to(users_path)
      end

      it 'ユーザーが登録されること' do
        expect do
          post users_path, params: valid_param
        end.to change(User, :count).by(1)
      end
    end

    context '不正な値を送信したとき' do
      let(:invalid_param) do
        {
          user: {
            name: '',
            email: ''
          }
        }
      end

      it 'ステータスコード422を返すこと' do
        post users_path, params: invalid_param
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post users_path, params: invalid_param
        end.not_to change(User, :count)
      end
    end
  end

  describe '#edit' do
    let!(:user) { create(:user) }

    it 'ステータスコード200を返すこと' do
      get edit_user_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#update' do
    let!(:user) { create(:user) }

    context '正常な値を送信したとき' do
      let(:valid_param) do
        {
          user: {
            name: 'Updated User',
            email: 'updated_user@test.com'
          }
        }
      end

      it 'indexにリダイレクトすること' do
        patch user_path(user), params: valid_param
        expect(response).to redirect_to(users_path)
      end

      it 'ユーザーが更新されること' do
        expect do
          patch user_path(user), params: valid_param
        end.to change { user.reload.name }.to('Updated User')
      end
    end

    context '不正な値を送信したとき' do
      let(:invalid_param) do
        {
          user: {
            name: '',
            email: ''
          }
        }
      end

      it 'ステータスコード422を返すこと' do
        patch user_path(user), params: invalid_param
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'ユーザーが更新されないこと' do
        expect do
          patch user_path(user), params: invalid_param
        end.not_to(change { user.reload.name })
      end
    end

    describe '#destroy' do
      let!(:user) { create(:user) }

      it 'indexにリダイレクトすること' do
        delete user_path(user)
        expect(response).to redirect_to(users_path)
      end

      it 'ユーザーが削除されること' do
        expect do
          delete user_path(user)
        end.to change(User, :count).by(-1)
      end
    end
  end
end
