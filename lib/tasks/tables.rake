# frozen_string_literal: true

require_relative '../schema_to_hash/schema_to_hash'

# rubocop:disable Metrics/BlockLength
namespace :tables do
  desc 'Create and destroy tables'
  task :create_and_destory, %w[host port dbname user password schema product] => :environment do |_task, args|
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

      product = Product.preload(tables: :columns).find_by(name: args[:product])
      if product.nil?
        puts "Product #{args[:product]} does not exist"
        exit
      end

      ActiveRecord::Base.transaction do
        puts 'Creating and destroying tables'
        Batches::CreateAndDestroyTables.new(
          existing_tables: product.tables,
          latest_table_hashes: schema_to_hash.tables(schema_name: args[:schema]),
          product:
        ).run

        puts 'Creating and destroying columns'
        product.tables.find_each do |table|
          Batches::CreateAndDestroyColumns.new(
            existing_columns: table.columns,
            latest_column_hashes: schema_to_hash.columns(schema_name: args[:schema], table_name: table.name),
            table:
          ).run
        end

        puts 'Relating foreign keys'
        Batches::RelateForeignKeys.new(
          tables: product.tables,
          foreign_key_hashes: schema_to_hash.foreign_keys(schema_name: args[:schema])
        ).run
      end
    ensure
      db.close
    end
  end
end
# rubocop:enable Metrics/BlockLength
