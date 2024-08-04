# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :tables do
  desc 'Create and destroy tables'
  task sync: :environment do
    Product.preload(tables: :columns).find_each do |product|
      puts "Syncing tables for #{product.name}..."

      db = SchemaToHash::Db.new(
        database_url: ENV.fetch("#{product.env_prefix}_DATABASE_URL"),
        postgres_schema: ENV.fetch("#{product.env_prefix}_DATABASE_SCHEMA", nil) || 'public'
      )

      fetcher = SchemaToHash::FetcherFactory.call(db:)

      next if fetcher.schemas.exclude?(db.schema)

      ActiveRecord::Base.transaction do
        Batches::CreateAndDestroyTables.new(
          existing_tables: product.tables,
          latest_table_hashes: fetcher.tables(schema_name: db.schema),
          product:
        ).run

        product.tables.find_each do |table|
          Batches::CreateAndDestroyColumns.new(
            existing_columns: table.columns,
            latest_column_hashes: fetcher.columns(
              schema_name: db.schema,
              table_name: table.name
            ),
            table:
          ).run
        end

        Batches::RelateForeignKeys.new(
          tables: product.tables,
          foreign_key_hashes: fetcher.foreign_keys(schema_name: db.schema)
        ).run
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
