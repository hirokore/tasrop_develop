require 'test_helper'

class TopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tops_index_url
    assert_response :success
  end

  test "should get contact" do
    get tops_contact_url
    assert_response :success
  end

  test "should get tutorial" do
    get tops_tutorial_url
    assert_response :success
  end

end
