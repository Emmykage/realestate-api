require "test_helper"

class EarningTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @earning_transaction = earning_transactions(:one)
  end

  test "should get index" do
    get earning_transactions_url, as: :json
    assert_response :success
  end

  test "should create earning_transaction" do
    assert_difference("EarningTransaction.count") do
      post earning_transactions_url, params: { earning_transaction: { amount: @earning_transaction.amount, earning_id: @earning_transaction.earning_id } }, as: :json
    end

    assert_response :created
  end

  test "should show earning_transaction" do
    get earning_transaction_url(@earning_transaction), as: :json
    assert_response :success
  end

  test "should update earning_transaction" do
    patch earning_transaction_url(@earning_transaction), params: { earning_transaction: { amount: @earning_transaction.amount, earning_id: @earning_transaction.earning_id } }, as: :json
    assert_response :success
  end

  test "should destroy earning_transaction" do
    assert_difference("EarningTransaction.count", -1) do
      delete earning_transaction_url(@earning_transaction), as: :json
    end

    assert_response :no_content
  end
end
