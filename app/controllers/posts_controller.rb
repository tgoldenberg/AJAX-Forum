class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @posts = Post.paginate(page: params[:page], :per_page => 10).order('created_at DESC')
  end

  def popular
    @posts = Post.paginate(page: params[:page], :per_page => 10).order('cached_votes_up DESC')
  end

  def search
    if params[:search].present?
      @posts = Post.search(params[:search])
    else
      @posts = Post.all
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to :back
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end

end
