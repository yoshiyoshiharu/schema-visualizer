# frozen_string_literal: true

RSpec.describe HomeController do
  include LoginSupport

  describe '#index' do
    before do
      login_as(create(:login_user))
    end

    context '通常のリクエストのとき' do
      before do
        get root_path
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end

      it 'SidebarのHTMLも返すこと' do
        assert_select 'aside'
      end
    end

    context 'Turboリクエストのとき' do
      before do
        get root_path, headers: { 'Turbo-Frame': 'table' }
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
