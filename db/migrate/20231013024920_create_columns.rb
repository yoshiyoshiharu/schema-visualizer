class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.references :table, null: false, foreign_key: true, comment: 'テーブルID'
      t.string :name, null: false, comment: 'カラム名'
      t.string :type, null: false, comment: 'カラム型'
      t.string :comment, comment: 'カラムコメント'

      t.timestamps
    end

    add_index :columns, [:table_id, :name], unique: true
  end
end
