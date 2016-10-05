class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @topics =  @category.topics.page(params[:page]).per(5)
  end
end
