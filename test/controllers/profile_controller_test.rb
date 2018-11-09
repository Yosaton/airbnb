require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get Show" do
    get profile_Show_url
    assert_response :success
  end

end
