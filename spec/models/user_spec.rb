# frozen_string_literal: true

RSpec.describe User do
  describe '.find_from_auth_hash(auth_hash)' do
    context 'auth_hashに含まれるメールアドレスに一致するユーザーがいるとき' do
      it 'ユーザーを返すこと' do
        user = create(:user, email: 'login_user@example.com')
        auth_hash = OmniAuth::AuthHash.new(
          info: {
            email: 'login_user@example.com'
          }
        )

        expect(described_class.find_from_auth_hash(auth_hash)).to eq user
      end
    end

    context 'auth_hashに含まれるメールアドレスに一致するユーザーがいないとき' do
      it 'nilを返すこと' do
        auth_hash = OmniAuth::AuthHash.new(
          info: {
            email: 'login_user@example.com'
          }
        )

        expect(described_class.find_from_auth_hash(auth_hash)).to be_nil
      end
    end
  end
end
