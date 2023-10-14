# frozen_string_literal: true

require_relative '../schema_to_hash/schema_to_hash'

namespace :tables do
  desc 'Create tables'
  task :create, ['product', 'schema_file_path'] => :environment do |_task, args|
    unless args[:product] && args[:schema_file_path]
      puts "Usage: rake tables:create[product,schema_file_path]"
      exit
    end

    schema_text = File.read(args[:schema_file_path])
    product =  Product.find_by(name: args[:product])

    if product.nil?
      puts "product: #{args[:product]} is not exist"
      exit
    end

    tables_hash = SchemaToHash::Scanner.new(schema_text).generate_table_list.to_hash

    ActiveRecord::Base.transaction do
      product.tables.destroy_all

      tables_hash.each do |table_hash|
        table = product.tables.create!(
          name: table_hash[:name],
          comment: table_hash[:comment].to_s
        )

        table_hash[:columns].each do |column_hash|
          table.columns.create!(
            name: column_hash[:name],
            comment: column_hash[:comment].to_s,
            type: column_hash[:type]
          )
        end

        log("Created #{table_hash}")
      end
    end
  end

  def log(text)
    puts text
  end
end
