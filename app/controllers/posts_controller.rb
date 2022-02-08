class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
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
end
