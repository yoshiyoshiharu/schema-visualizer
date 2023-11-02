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

    scanner_hash = SchemaToHash::Scanner.new(schema_text).execute.to_hash
    tables_hash = scanner_hash[:tables]
    foreign_keys_hash = scanner_hash[:foreign_keys]

    ActiveRecord::Base.transaction do
      product.tables.map(&:columns).flatten.each(&:destroy!)
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

        log("Created Table: #{table_hash}")
      end

      foreign_keys_hash.each do |foreign_key_hash|
        from_table = product.tables.find_by!(name: foreign_key_hash[:from_table_name])
        from_column = from_table.columns.find_by!(name: foreign_key_hash[:from_column_name])
        to_table = product.tables.find_by!(name: foreign_key_hash[:to_table_name])

        puts from_table.name
        puts to_table.name
        puts from_column.name

        from_column.update!(foreign_key_table: to_table)

        log("Created Foreign Key: #{foreign_key_hash}")
      end
    end
  end

  def log(text)
    puts text
  end
end
