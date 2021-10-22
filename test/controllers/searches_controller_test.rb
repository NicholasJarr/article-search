require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searches_path
    assert_response :success

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'th', 'Query'
        assert_select 'th', 'IP Address'
      end
    end
  end
end
