# frozen_string_literal: true

require_relative '../lib/schema_to_hash/schema_to_hash'

data = JSON.parse(File.read(Rails.root.join('db/json/sample_data.json')))

Column.destroy_all
Table.destroy_all
Product.destroy_all

data.each do |product_data|
  product = Product.create!(
    id: product_data["id"],
    name: product_data["name"]
  )

  product_data["tables"].each do |table_data|
    table = product.tables.create!(
      id: table_data["id"],
      name: table_data["name"],
      comment: table_data["comment"]
    )

    table_data["columns"].each do |column_data|
      table.columns.create!(
        id: column_data["id"],
        name: column_data["name"],
        type: column_data["type"],
        comment: column_data["comment"],
        primary_key: column_data["primary_key"] || false,
        nullable: column_data["nullable"] || false,
        foreign_key_table_id: column_data["foreign_key_table_id"]
      )
    end
  end
end
