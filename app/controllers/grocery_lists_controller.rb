class GroceryListsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_grocery_list, only: [:show, :edit, :update, :destroy]

  def index
    @grocery_lists = current_user.house.grocery_lists
    respond_to do |format|
      format.html
      format.json { render json: @grocery_lists }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @grocery_list }
    end
  end

  def new
    @grocery_list = GroceryList.new
  end

  def create
    @grocery_list = GroceryList.new(grocery_list_params)

    respond_to do |format|
      begin
        @grocery_list.house = current_user.house
        @grocery_list.save!
        format.html { redirect_to grocery_list_path @grocery_list }
        format.json { render json: @grocery_list }
      rescue ActiveRecord::RecordNotUnique
        flash[:notice] = 'List already included in for house'
        format.html { redirect_to grocery_lists_path }
      rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = e.message
        format.html { render "grocery_lists/new" }
      end
    end

  end

  def edit
  end

  def update
    if @grocery_list.update(grocery_list_params)
      redirect_to grocery_list_path @grocery_list
    else
      render action: 'edit'
    end
  end

  def destroy
    @grocery_list.destroy
    redirect_to grocery_lists_path
  end

  def set_grocery_list
    @grocery_list = GroceryList.find(params[:id])
  end

  def subscribe
    @grocery_list = GroceryList.find(params[:id])
    @grocery_list.users << current_user
    respond_to do |format|
      format.html {redirect_to grocery_list_path @grocery_list}
      format.json {render json: @grocery_list}
    end
  end

  def unsubscribe
    @grocery_list = GroceryList.find(params[:id])
    @grocery_list.users.delete(current_user)
    respond_to do |format|
      format.html {redirect_to grocery_list_path @grocery_list}
      format.json {render json: @grocery_list}
    end
  end

  def grocery_list_params
    params.require(:grocery_list).permit(:name)
  end
end
