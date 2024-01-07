# frozen_string_literal: true

RSpec.describe ProductsController do
  include LoginSupport

  describe '#index' do
    before do
      login_as(create(:login_user))
    end

    context '通常のリクエストのとき' do
      before do
        get products_path
      end

      it 'ステータスコード422を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストのとき' do
      before do
        get products_path, headers: { 'Turbo-Frame': 'table' }
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end

      it 'SidebarのHTMLは返さないこと' do
        assert_select 'aside', false
      end
    end
  end
end
