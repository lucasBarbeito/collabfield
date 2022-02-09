class PostsController < ApplicationController

  before_action :redirect_if_not_signed_in, only: [:new]


  def show
    @post = Post.find(params[:id])
    if user_signed_in?
      @message_has_been_sent = conversation_exist?
    end  end

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  def hobby
    posts_for_branch(params[:action])
  end

  def study
    posts_for_branch(params[:action])
  end

  def team
    posts_for_branch(params[:action])
  end

  private

  def posts_for_branch(branch)
    #In the @categories instance variable we retrieve all categories for a specific branch.
    #  I.e. if you go to the hobby branch page, all categories which belong to  the hobby branch will be retrieved.
    @categories = Category.where(branch: branch)
    #o get and store posts inside the @posts instance variable,
    # get_posts method is used and then it is chained with a paginate method. paginate method comes from will_paginate gem
    @posts = get_posts.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: 'posts/posts_pagination_page' }
    end
  end

  def get_posts
    PostsForBranchService.new({
       search: params[:search],
       category: params[:category],
       branch: params[:action]}).call
  end

  def post_params
    #The permit method is used to whitelist attributes of the object, so only these specified attributes are allowed to be passed.
    params.require(:post).permit(:content, :title, :category_id).merge(user_id: current_user.id)
  end

  def conversation_exist?
    Private::Conversation.between_users(current_user.id, @post.user.id).present?
  end
end
