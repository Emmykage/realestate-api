require "test_helper"

class InvestmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investment = investments(:one)
  end

  test "should get index" do
    get investments_url, as: :json
    assert_response :success
  end

  test "should create investment" do
    assert_difference("Investment.count") do
      post investments_url, params: { investment: { min_value: @investment.min_value, name: @investment.name } }, as: :json
    end

    assert_response :created
  end

  test "should show investment" do
    get investment_url(@investment), as: :json
    assert_response :success
  end

  test "should update investment" do
    patch investment_url(@investment), params: { investment: { min_value: @investment.min_value, name: @investment.name } }, as: :json
    assert_response :success
  end

  test "should destroy investment" do
    assert_difference("Investment.count", -1) do
      delete investment_url(@investment), as: :json
    end

    assert_response :no_content
  end
end
