require "test_helper"

class PortfolioInterestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @portfolio_interest = portfolio_interests(:one)
  end

  test "should get index" do
    get portfolio_interests_url, as: :json
    assert_response :success
  end

  test "should create portfolio_interest" do
    assert_difference("PortfolioInterest.count") do
      post portfolio_interests_url, params: { portfolio_interest: { interest: @portfolio_interest.interest, portfolio_id: @portfolio_interest.portfolio_id } }, as: :json
    end

    assert_response :created
  end

  test "should show portfolio_interest" do
    get portfolio_interest_url(@portfolio_interest), as: :json
    assert_response :success
  end

  test "should update portfolio_interest" do
    patch portfolio_interest_url(@portfolio_interest), params: { portfolio_interest: { interest: @portfolio_interest.interest, portfolio_id: @portfolio_interest.portfolio_id } }, as: :json
    assert_response :success
  end

  test "should destroy portfolio_interest" do
    assert_difference("PortfolioInterest.count", -1) do
      delete portfolio_interest_url(@portfolio_interest), as: :json
    end

    assert_response :no_content
  end
end
