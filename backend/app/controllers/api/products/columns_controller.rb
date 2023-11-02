# frozen_string_literal: true

class Api::Products::ColumnsController < ApplicationController
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
