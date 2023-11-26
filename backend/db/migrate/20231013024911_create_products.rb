# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, comment: 'プロダクト' do |t|
      t.string :name, null: false, comment: 'プロダクト名'

      t.timestamps
    end

    add_index :products, [:name], unique: true
  end
end
