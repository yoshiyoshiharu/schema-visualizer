# frozen_string_literal: true

RSpec.describe ColumnsController do
  include LoginSupport

  describe '#index' do
    before do
      login_as(create(:login_user))
    end

    context '通常のリクエストのとき' do
      before do
        get columns_path
      end

      it 'ステータスコード404を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストのとき' do
      before do
        get columns_path, headers: { 'Turbo-Frame': 'columns' }
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
