# frozen_string_literal: true

class TablesController < ApplicationController
  def index
    @products_with_table = if params[:name].blank?
                             Product.preload(:tables).all
                           else
                             Product.eager_load(:tables).merge(Table.name_like(params[:name]))
                           end
  end

  def show
    @products_with_table = Product.all.preload(:tables) unless turbo_frame_request?

    @table = Table.preload(columns: %i[memo foreign_key_table]).find(params[:id])
  end
end
