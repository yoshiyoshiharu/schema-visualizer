# frozen_string_literal: true
#
require_relative '../lib/schema_to_hash/schema_to_hash'

(1..3).each do |i|
  Product.find_or_create_by!(
    {
      name: "Product#{i}"
    }
  )
end

Product.all.each do |product|
  (1..3).each do |i|
    product.tables.find_or_create_by!(
      {
        name: "#{product.name}-Table#{i}",
        comment: "#{product.name}のテーブル#{i}"
      }
    )
  end
end

Table.all.each do |table|
  (1..3).each do |i|
    table.columns.find_or_create_by!(
      {
        name: "#{table.name}-Column#{i}",
        type: SchemaToHash::TYPE.sample,
        comment: "#{table.name}のカラム#{i}"
      }
    )
  end
end
