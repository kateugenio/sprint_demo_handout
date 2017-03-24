require 'test_helper'

class HandoutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get handout_index_url
    assert_response :success
  end

end
