class CommentsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:comment))
    @comment.user_id = current_user.id if current_user
    @comment.save
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) }
        format.js
      else
        format.html { render action: 'new'}
        format.js
      end
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(params[:comment].permit(:comment))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  def upvote
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.upvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { count: @comment.get_upvotes.size, countTwo: @comment.get_downvotes.size }}
    end
  end

  def downvote
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.downvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { count: @comment.get_downvotes.size, countTwo: @comment.get_upvotes.size }}
    end
  end

end
