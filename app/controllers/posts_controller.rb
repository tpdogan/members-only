class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_member!, except: [:index, :show]

  def index
    @posts = Post.all.order("created_at DESC")
    @post = Post.new
    @members = Member.all
  end

  def show
    @posts = Post.all.order("created_at DESC")
    @members = Member.all
  end

  def new
    @post = current_member.posts.build
  end

  def edit
    @posts = Post.all.order("created_at DESC")
    @members = Member.all
  end

  def create
    @post = current_member.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
      else
        @posts = Post.all
        flash[:alert] = @post.errors.count
        format.html { render :index, alert: 'Post was not created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :member_id)
    end
end
