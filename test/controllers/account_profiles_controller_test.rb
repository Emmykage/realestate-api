require "test_helper"

class AccountProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account_profile = account_profiles(:one)
  end

  test "should get index" do
    get account_profiles_url, as: :json
    assert_response :success
  end

  test "should create account_profile" do
    assert_difference("AccountProfile.count") do
      post account_profiles_url, params: { account_profile: { bank: @account_profile.bank, bitcoin: @account_profile.bitcoin, ethereum: @account_profile.ethereum, usdt: @account_profile.usdt } }, as: :json
    end

    assert_response :created
  end

  test "should show account_profile" do
    get account_profile_url(@account_profile), as: :json
    assert_response :success
  end

  test "should update account_profile" do
    patch account_profile_url(@account_profile), params: { account_profile: { bank: @account_profile.bank, bitcoin: @account_profile.bitcoin, ethereum: @account_profile.ethereum, usdt: @account_profile.usdt } }, as: :json
    assert_response :success
  end

  test "should destroy account_profile" do
    assert_difference("AccountProfile.count", -1) do
      delete account_profile_url(@account_profile), as: :json
    end

    assert_response :no_content
  end
end
