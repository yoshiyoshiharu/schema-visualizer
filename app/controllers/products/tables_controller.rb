# frozen_string_literal: true

module Products
  class TablesController < ApplicationController
    def index
      @tables = if params[:name_like].blank?
                  Product.all
                else
                  Product.eager_load(:tables)
                         .merge(Table.name_like(params[:name_like]))
                end
    end
  end
end