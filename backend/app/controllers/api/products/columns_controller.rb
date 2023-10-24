# frozen_string_literal: true

class Api::Products::ColumnsController < ApplicationController
  def index
    columns = if params[:name_like].blank?
                Column.none
              else
                Product.eager_load(tables: :columns)
                       .merge(Column.name_like(params[:name_like]))
              end

    render json: columns,
           include:{
             tables: {
               include: {
                 columns: {
                   only: :name
                 }
               },
               only: [:id, :name]
             }
           },
           only: :name
  end
end
