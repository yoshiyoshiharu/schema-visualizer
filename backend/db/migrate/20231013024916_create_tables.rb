class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables, comment: 'テーブル' do |t|
      t.references :product, null: false, foreign_key: true, comment: 'プロダクトID'
      t.string :name, null: false, comment: 'テーブル名'
      t.string :comment, null: false, default: '', comment: 'テーブルコメント'

      t.timestamps
    end

    add_index :tables, [:product_id, :name], unique: true
  end
end
