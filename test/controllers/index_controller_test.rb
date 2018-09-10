require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get matches" do
    get index_matches_url
    assert_response :success
  end

end
