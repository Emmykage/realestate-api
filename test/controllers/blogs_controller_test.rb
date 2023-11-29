require "test_helper"

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
  end

  test "should get index" do
    get blogs_url, as: :json
    assert_response :success
  end

  test "should create blog" do
    assert_difference("Blog.count") do
      post blogs_url, params: { blog: { body: @blog.body, secondary_text: @blog.secondary_text, title: @blog.title, user_id: @blog.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show blog" do
    get blog_url(@blog), as: :json
    assert_response :success
  end

  test "should update blog" do
    patch blog_url(@blog), params: { blog: { body: @blog.body, secondary_text: @blog.secondary_text, title: @blog.title, user_id: @blog.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy blog" do
    assert_difference("Blog.count", -1) do
      delete blog_url(@blog), as: :json
    end

    assert_response :no_content
  end
end
