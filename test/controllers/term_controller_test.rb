require 'test_helper'

class TermControllerTest < ActionController::TestCase
  test "should get explore" do
    get :explore
    assert_response :success
  end

end
