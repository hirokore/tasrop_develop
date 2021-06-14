require 'test_helper'

class CustomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customs_index_url
    assert_response :success
  end

  test "should get show" do
    get customs_show_url
    assert_response :success
  end

  test "should get edit" do
    get customs_edit_url
    assert_response :success
  end

end
