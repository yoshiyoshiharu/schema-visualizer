# frozen_string_literal: true

RSpec.describe ColumnMemosController do
  include LoginSupport

  before do
    login_as(create(:login_user))
  end

  describe '#show' do
    let!(:column) { create(:column) }

    context '通常のリクエストの場合' do
      before do
        get column_memo_path(column)
      end

      it 'ステータスコード404を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストの場合' do
      before do
        get column_memo_path(column), headers: { 'Turbo-Frame': "column_#{column.id}" }
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#edit' do
    let!(:column) { create(:column) }

    context '通常のリクエストの場合' do
      before do
        get edit_column_memo_path(column)
      end

      it 'ステータスコード404を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストの場合' do
      before do
        get edit_column_memo_path(column), headers: { 'Turbo-Frame': "column_#{column.id}" }
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#update' do
    let!(:column) { create(:column) }
    let!(:column_memo) { create(:column_memo, column:) }

    context '通常のリクエストの場合' do
      it 'ステータスコード404を返すこと' do
        patch column_memo_path(column)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストで正常な値を送信した場合' do
      let(:valid_param) do
        {
          column_memo: {
            content: 'Updated memo'
          }
        }
      end

      it 'ステータスコード200を返すこと' do
        patch column_memo_path(column),
              params: valid_param,
              headers: { 'Turbo-Frame': "column_#{column.id}", Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:ok)
      end

      it 'メモが更新されること' do
        expect do
          patch column_memo_path(column),
                params: valid_param,
                headers: { 'Turbo-Frame': "column_#{column.id}", Accept: 'text/vnd.turbo-stream.html' }
        end.to change { column_memo.reload.content }.to('Updated memo')
      end
    end
  end
end
