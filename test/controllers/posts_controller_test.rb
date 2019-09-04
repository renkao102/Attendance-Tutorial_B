require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get base" do
    get posts_base_url
    assert_response :success
  end

end
