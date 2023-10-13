class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.references :table, null: false, foreign_key: true, comment: 'テーブルID' 
      t.references :column_type, null: false, foreign_key: true, comment: 'カラム型ID'
      t.string :name, null: false, comment: 'カラム名'

      t.timestamps
    end

    add_index :columns, [:table_id, :name], unique: true
  end
end
