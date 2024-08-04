# frozen_string_literal: true

class AddEnvPrefixToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :env_prefix, :string, null: false, default: ''
    add_index :products, [:name, :env_prefix], unique: true
  end
end
