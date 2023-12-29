# frozen_string_literal: true

class CreateColumnComments < ActiveRecord::Migration[7.1]
  def change
    create_table :column_memos do |t|
      t.references :column, null: false, foreign_key: true, comment: 'カラムID'
      t.string :content, null: false, default: '', comment: '内容'

      t.timestamps
    end
  end
end
