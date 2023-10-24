# frozen_string_literal: true

class Api::Products::TablesController < ApplicationController
  def index
    products = Product.all
    render json: products, include: :tables
  end
end
