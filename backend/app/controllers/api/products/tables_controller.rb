# frozen_string_literal: true

class Api::Products::TablesController < ApplicationController
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
