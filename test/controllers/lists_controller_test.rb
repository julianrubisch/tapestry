require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    skip
    get lists_url
    assert_response :success
  end
end
