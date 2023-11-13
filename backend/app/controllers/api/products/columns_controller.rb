# frozen_string_literal: true

module Api
  module Products
    class ColumnsController < ApplicationController
      def index
        columns = if params[:name_like].blank?
                    Product.none
                  else
                    Product.eager_load(tables: :columns)
                           .merge(Column.name_like(params[:name_like]))
                  end

        render json: columns,
               include: {
                 tables: {
                   include: {
                     columns: {
                       only: %i[id name]
                     }
                   },
                   only: %i[id name]
                 }
               },
               only: %i[id name]
      end
    end
  end
end
