# frozen_string_literal: true

RSpec.describe TablesController do
  include LoginSupport

  describe '#index' do
    before do
      login_as(create(:login_user))
    end

    context '通常のリクエストのとき' do
      before do
        get tables_path
      end

      it 'ステータスコード404を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストのとき' do
      before do
        get tables_path, headers: { 'Turbo-Frame': 'tables' }
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#show' do
    let!(:table) { create(:table) }

    before do
      login_as(create(:login_user))
    end

    context '通常のリクエストのとき' do
      before do
        get table_path(table)
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:success)
      end

      it 'SidebarのHTMLも返すこと' do
        assert_select 'aside'
      end
    end

    context 'Turboリクエストのとき' do
      before do
        get table_path(table), headers: { 'Turbo-Frame': 'table' }
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
