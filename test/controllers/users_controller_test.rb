require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get base" do
    get users_base_url
    assert_response :success
  end

end
