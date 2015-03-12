class CategoriesController < ApplicationController
  respond_to :html, :js

def show
  @category = Category.find(params[:id])
  @posts = @category.posts.paginate(page: params[:page], :per_page => 10).order('created_at DESC')
end


end
