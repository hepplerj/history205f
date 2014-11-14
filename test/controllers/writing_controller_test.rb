require 'test_helper'

class WritingControllerTest < ActionController::TestCase
  test "should get methodology" do
    get :methodology
    assert_response :success
  end

  test "should get thoughts" do
    get :thoughts
    assert_response :success
  end

end
