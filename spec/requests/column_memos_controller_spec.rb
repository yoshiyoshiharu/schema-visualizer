# frozen_string_literal: true

RSpec.describe ColumnMemosController do
  include LoginSupport

  before do
    login_as(create(:login_user))
  end

  describe '#show' do
    let!(:column) { create(:column) }

    context '通常のリクエストのとき' do
      before do
        get column_memo_path(column)
      end

      it 'ステータスコード404を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストのとき' do
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

    context '通常のリクエストのとき' do
      before do
        get edit_column_memo_path(column)
      end

      it 'ステータスコード404を返すこと' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストのとき' do
      before do
        get edit_column_memo_path(column), headers: { 'Turbo-Frame': "column_#{column.id}" }
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # update は TurboStremaリクエストなので修正する
  describe '#update' do
    let!(:column) { create(:column) }

    context '通常のリクエストのとき' do
      it 'ステータスコード404を返すこと' do
        patch column_memo_path(column)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Turboリクエストのとき' do
      context '正常な値を送信したとき' do
        let(:valid_param) do
          {
            column_memo: {
              content: 'Updated memo'
            }
          }
        end

        it 'showにリダイレクトすること' do
          patch column_memo_path(column), params: valid_param, headers: { 'Turbo-Frame': "column_#{column.id}" }
          pp response.body
          expect(response).to redirect_to(column_memo_path(column))
        end

        it 'メモが更新されること' do
          expect do
            patch column_memo_path(column), params: valid_param, headers: { 'Turbo-Frame': "column_#{column.id}" }
          end.to change { column.reload.memo.content }.to('Updated memo')
        end
      end
    end
  end
end
