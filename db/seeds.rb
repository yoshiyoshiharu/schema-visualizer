# frozen_string_literal: true

ColumnType.create!(
  [
    { name: "string" },
    { name: "integer" },
    { name: "float" },
    { name: "boolean" },
    { name: "date" },
    { name: "datetime" },
    { name: "text" }
  ]
)
    
(1..3).each do |i|
  Product.create!(
    {
      name: "Product#{i}"
    }
  )
end

Product.all.each do |product|
  (1..3).each do |i|
    product.tables.create!(
      {
        name: "#{product.name}-Table#{i}"
      }
    )
  end
end

Table.all.each do |table|
  (1..3).each do |i|
    table.columns.create!(
      {
        name: "#{table.name}-Column#{i}",
        column_type: ColumnType.all.sample
      }
    )
  end
end
