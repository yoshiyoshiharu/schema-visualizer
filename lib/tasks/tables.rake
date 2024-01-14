# frozen_string_literal: true

require_relative '../schema_to_hash/schema_to_hash'

# rubocop:disable Metrics/BlockLength
# rubocop:disable Layout/LineLength
namespace :tables do
  desc 'Create tables'
  task :create, %w[host port dbname user password schema product] => :environment do |_task, args|
    unless args[:host] &&
           args[:port] &&
           args[:dbname] &&
           args[:user] &&
           args[:password] &&
           args[:schema] &&
           args[:product]
      puts 'Usage: rake tables:create[host,port,dbname,user,password,schema,product]'
      exit
    end

    db_config = {
      host: args[:host],
      port: args[:port],
      dbname: args[:dbname],
      user: args[:user],
      password: args[:password]
    }

    begin
      db = SchemaToHash::Db.connect(**db_config)

      schema_to_hash = SchemaToHash::Fetcher.new(db:)

      unless schema_to_hash.schemas.include?(args[:schema])
        puts "Schema #{args[:schema]} does not exist"
        exit
      end

      product = Product.find_by(name: args[:product])
      if product.nil?
        puts "Product #{args[:product]} does not exist"
        exit
      end

      puts "Deleting columns for #{args[:product]}..."
      Column.joins(table: :product).where(table: { product: Product.find_by(name: 'Supplier') }).delete_all
      puts "Deleting tables for #{args[:product]}..."
      product.tables.delete_all

      schema_to_hash.tables(schema_name: args[:schema]).each do |table|
        puts "Creating table #{table[:name]}..."
        product.tables.create!(
          name: table[:name],
          comment: table[:comment] || '',
          columns: table[:columns].map do |column|
            Column.new(
              name: column[:name],
              type: column[:type],
              comment: column[:comment] || '',
              nullable: column[:nullable],
              primary_key: column[:primary_key]
            )
          end
        )
      end

      schema_to_hash.foreign_keys(schema_name: args[:schema]).each do |foreign_key|
        puts "Creating foreign key #{foreign_key[:from_column_name]} of #{foreign_key[:from_table_name]} to #{foreign_key[:to_table_name]}..."
        from_table = product.tables.find_by!(name: foreign_key[:from_table_name])
        from_column = from_table.columns.find_by!(name: foreign_key[:from_column_name])
        to_table = product.tables.find_by!(name: foreign_key[:to_table_name])

        from_column.update!(
          foreign_key_table: to_table
        )
      end
    ensure
      db.close
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Layout/LineLength
