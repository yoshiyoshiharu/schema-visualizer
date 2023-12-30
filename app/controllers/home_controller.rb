# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @products_with_table = Product.preload(:tables).all
  end
end
