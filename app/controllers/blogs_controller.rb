class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :publish_blog]
  include BlogsHelper

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
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

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @blog.update(blog_params)
    @blog.url=clean_url(blog_params[:url])
    respond_to do |format|
      if @blog.save
        format.html { redirect_to :update_blog, notice: 'Blog was successfully updated, don\'t forget to publish changes.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish_blog
    @blog.publish()

    respond_to do |format|
      if @blog.last_published_status
        format.html { redirect_to :root, notice: "Blog was successfully published at #{Time.now}. Changes may take upto 5 minutes to reflect." }
      else
        format.html { redirect_to :root, alert: "Please publish again, failed at #{Time.now}." }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      if params[:id]
        @blog = Blog.find(params[:id])
      else
        @blog = current_user.blogs.first
      end
      if @blog.user_id!=current_user.id
        @blog = nil
        respond_to do |format|
          format.html { redirect_to :root, notice: 'Uauthorized access.' }
          format.json { head :no_content }
        end
      else
        @blog
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:email,:description,:twitter,:about, :title, :author_name, :author_image, :cover_image, :google_analytics, :theme, :url)
    end
end
