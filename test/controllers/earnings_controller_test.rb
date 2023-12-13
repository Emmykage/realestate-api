require "test_helper"

class EarningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @earning = earnings(:one)
  end

  test "should get index" do
    get earnings_url, as: :json
    assert_response :success
  end

  test "should create earning" do
    assert_difference("Earning.count") do
      post earnings_url, params: { earning: { user_id: @earning.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show earning" do
    get earning_url(@earning), as: :json
    assert_response :success
  end

  test "should update earning" do
    patch earning_url(@earning), params: { earning: { user_id: @earning.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy earning" do
    assert_difference("Earning.count", -1) do
      delete earning_url(@earning), as: :json
    end

    assert_response :no_content
  end
end
