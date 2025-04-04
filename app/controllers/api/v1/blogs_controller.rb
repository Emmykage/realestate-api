class Api::V1::BlogsController < ApplicationController
  before_action :authorize, except: %i[ index show]
  before_action :set_blog, only: %i[ show update destroy ]



  # GET /blogs
  def index
    @blogs = Blog.all

    render json:{data: ActiveModelSerializers::SerializableResource.new(@blogs)}
  end

  # GET /blogs/1
  def show
    render json: {data: BlogSerializer.new(@blog)}
  end

  # POST /blogs
  def create
    @blog = @current_user.blogs.new(blog_params)

    if @blog.save
      render json: {data: @blog}, status: :created
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :blog_body, :image, :date)
    end
end
