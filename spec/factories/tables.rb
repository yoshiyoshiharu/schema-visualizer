# frozen_string_literal: true

FactoryBot.define do
  factory :table do
    product
    name { 'テスト' }
  end
end
