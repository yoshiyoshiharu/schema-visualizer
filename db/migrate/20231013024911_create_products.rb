class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, unique: true, comment: 'プロダクト名'

      t.timestamps
    end
  end
end
