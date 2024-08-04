# frozen_string_literal: true

RSpec.describe User do
  describe '.find_from_auth_hash(auth_hash)' do
    subject do
      auth_hash = OmniAuth::AuthHash.new(
        info: {
          email: 'login_user@example.com'
        }
      )

      described_class.find_from_auth_hash(auth_hash)
    end

    context 'auth_hashに含まれるメールアドレスに一致するユーザーがいる場合' do
      let!(:user) { create(:user, email: 'login_user@example.com') }

      it { is_expected.to eq user }
    end

    context 'auth_hashに含まれるメールアドレスに一致するユーザーがいない場合' do
      it { is_expected.to be_nil }
    end
  end
end
