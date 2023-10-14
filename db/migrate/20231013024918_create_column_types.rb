class CreateColumnTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :column_types, comment: 'カラム型マスタ' do |t|
      t.string :name, null: false, unique: true, comment: 'カラム型名'

      t.timestamps
    end
  end
end
