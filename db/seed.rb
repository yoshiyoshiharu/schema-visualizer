# frozen_string_literal: true

3.times do |i|
  Product.create!(
    {
      name: "Product#{i}"
    }
  )
end

Product.all.each do |product|
  3.times do |i|
    product.tables.create!(
      {
        name: "#{prodcut.name}-Table#{i}"
      }
    )
  end
end

Table.all.each do |table|
  3.times do |i|
    table.columns.create!(
      {
        name: "#{table.name}-Column#{i}"
        type: Type.all.sample
      }
    )
  end
end
