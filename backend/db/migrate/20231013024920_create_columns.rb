class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns, comment: 'カラム' do |t|
      t.references :table, null: false, foreign_key: true, comment: 'テーブルID'
      t.string :name, null: false, comment: 'カラム名'
      t.string :type, null: false, comment: 'カラム型'
      t.string :comment, null: false, default: '', comment: 'カラムコメント'
      t.boolean :nullable, null: false, default: false, comment: 'NULL許容フラグ'
      t.boolean :primary_key, null: false, default: false, comment: '主キーフラグ'
      t.references :foreign_key_table, foreign_key: { to_table: :tables }, comment: '外部キー先テーブル'

      t.timestamps
    end

    add_index :columns, [:table_id, :name], unique: true
  end
end
