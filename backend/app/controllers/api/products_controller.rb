# frozen_string_literal: true

class Api::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, include: :tables
  end
end
