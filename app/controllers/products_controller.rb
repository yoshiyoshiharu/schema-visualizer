# frozen_string_literal: true

class ProductsController < ApplicationController
  layout 'without_sidebar'
  before_action :require_current_user_is_admin

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = @product.name + t('.success')
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      flash[:notice] = @product.name + t('.success')
      redirect_to products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy!
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :env_prefix)
  end
end
