require "test_helper"

class InboxControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    skip
    get inbox_show_url
    assert_response :success
  end
end
