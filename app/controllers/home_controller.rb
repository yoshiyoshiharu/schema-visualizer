# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    return if turbo_frame_request?

    @products_with_table = Product.preload(:tables).all
    @products_with_column = Product.none
  end
end
