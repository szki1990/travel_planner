require "test_helper"

class CheckListControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get check_list_new_url
    assert_response :success
  end

  test "should get index" do
    get check_list_index_url
    assert_response :success
  end

  test "should get show" do
    get check_list_show_url
    assert_response :success
  end

  test "should get edit" do
    get check_list_edit_url
    assert_response :success
  end
end
