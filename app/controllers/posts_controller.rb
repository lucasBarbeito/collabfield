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
  end

  def get_posts
    branch = params[:action]
    search = params[:search]
    category = params[:category]

    if category.blank? && search.blank?
        posts = Post.by_branch(branch).all
      elsif category.blank? && search.present?
        posts = Post.by_branch(branch).search(search)
      elsif category.present? && search.blank?
        posts = Post.by_category(branch, category)
      elsif category.present? && search.present?
        posts = Post.by_category(branch, category).search(search)
      else
    end
  end

end
