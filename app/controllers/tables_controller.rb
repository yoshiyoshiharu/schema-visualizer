# frozen_string_literal: true

class TablesController < ApplicationController
  def show
    @products = Product.all.preload(:tables) unless turbo_frame_request?

    @table = Table.preload(columns: [:memo, :foreign_key_table]).find(params[:id])
  end
end
