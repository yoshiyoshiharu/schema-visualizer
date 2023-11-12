# frozen_string_literal: true

module Api
  module Products
    class TablesController < ApplicationController
      def index
        tables = if params[:name_like].blank?
                   Product.all
                 else
                   Product.eager_load(:tables)
                          .merge(Table.name_like(params[:name_like]))
                 end

        render json: tables,
               include: {
                 tables: {
                   only: %i[id name]
                 }
               },
               only: %i[id name]
      end
    end
  end
end
