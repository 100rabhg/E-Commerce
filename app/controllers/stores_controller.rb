class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_have_not_store, only: %i[new create]
  before_action :ensure_user_have_store, only: %i[destory edit update show]
  load_and_authorize_resource

  def new
    @store = Store.new
    authorize! :manage, @store
  end

  def show
    @store = current_user.store
    authorize! :manage, @store
  end

  def create
    @store = Store.new(store_params)
    authorize! :manage, @store
    if (current_user.store = @store)
      redirect_to store_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @store = current_user.store
    authorize! :manage, @store
  end

  def update
    @store = current_user.store
    authorize! :manage, @store
    if @store.update(store_params)
      redirect_to store_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ensure_user_have_not_store
    return unless current_user.store

    redirect_to store_path
  end

  def ensure_user_have_store
    return if current_user.store

    redirect_to new_store_path
  end

  def store_params
    params.require(:store).permit(:name, :description)
  end
end
