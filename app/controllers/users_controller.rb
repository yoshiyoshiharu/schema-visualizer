# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'without_sidebar'
  before_action :require_current_user_is_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = @user.name + t('.success')
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = @user.name + t('.success')
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_admin)
  end
end
