# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: '', index: { unique: true }

      t.timestamps
    end
  end
end
