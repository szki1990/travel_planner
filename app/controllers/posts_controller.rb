class PostsController < ApplicationController
  
  def index
    @books = Book.posts
  end
end

