# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'haruki.osaka.u@gmail.com' }
  end

  factory :login_user, class: 'User' do
    name { 'ログインユーザー' }
    email { 'login_user@test.com' }
  end
end
