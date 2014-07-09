class BlogsController < ApplicationController
  before_action :set_blog, only: [ :edit, :update, :destroy]
  before_action :authenticate, except: :index
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.reverse_order.page params[:page]
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to manage_blogs_path, notice: 'Blog was successfully created.'
    else
      render action: 'new'
    end
  end

  def manage
    @blogs = Blog.all.reverse_order.page params[:page]
    @blog = Blog.new
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    redirect_to manage_blogs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body)
    end
end
