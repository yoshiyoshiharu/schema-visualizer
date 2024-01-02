# frozen_string_literal: true

FactoryBot.define do
  factory :column do
    table
    name { 'テスト' }
    type { 'integer' }
  end
end
