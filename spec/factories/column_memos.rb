# frozen_string_literal: true

FactoryBot.define do
  factory :column_memo do
    column
    content { 'メモ' }
  end
end
