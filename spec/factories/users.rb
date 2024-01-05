# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'haruki.osaka.u@gmail.com' }
  end
end
