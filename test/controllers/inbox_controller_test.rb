require "test_helper"

class InboxControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get inbox_show_url
    assert_response :success
  end
end
