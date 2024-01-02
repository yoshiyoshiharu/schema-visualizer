# frozen_string_literal: true

require_relative '../lib/schema_to_hash/schema_to_hash'

data = JSON.parse(File.read(Rails.root.join('db/json/sample_data.json')))

data.each do |product_data|
  product = Product.create!(name: product_data["name"])

  product_data["tables"].each do |table_data|
    table = product.tables.create!(name: table_data["name"], comment: table_data["comment"])

    table_data["columns"].each do |column_data|
      table.columns.create!(
        name: column_data["name"],
        type: column_data["type"],
        comment: column_data["comment"]
      )
    end
  end
end
