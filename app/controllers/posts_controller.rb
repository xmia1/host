class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  include PostsHelper

  # GET /posts
  # GET /posts.json
  def index
    @posts = current_user.blogs.first.posts
    @posts=@posts.paginate(:page => params[:page]).order('created_at DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post=Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.path=file_path(post_params[:name])
    @post.header=post_header(post_params[:name])
    @post.blog_id=current_user.blogs.first.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created. Don\'t forget to publish changes.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if post_params[:name]!=@post.name
      @post.path=file_path(post_params[:name])
      @post.header=post_header(post_params[:name])
    end
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated. Don\'t forget to publish changes.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      if @post.blog.user_id!=current_user.id
        @post = nil
        respond_to do |format|
          format.html { redirect_to posts_url, notice: 'Uauthorized access.' }
          format.json { head :no_content }
        end
      else
        @post
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.fetch(:post, {}).permit(:content,:name,:header,:mark_work_in_progress)
    end
end
