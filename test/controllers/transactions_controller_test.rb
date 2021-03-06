require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get transactions_create_url
    assert_response :success
  end

  test "should get update" do
    get transactions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get transactions_destroy_url
    assert_response :success
  end

  test "should get compare" do
    get transactions_compare_url
    assert_response :success
  end

end
