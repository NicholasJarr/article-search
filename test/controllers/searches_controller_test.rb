require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searches_path
    assert_response :success

    assert_select 'table' do
      assert_select 'thead' do
        assert_select 'td', 'Query'
        assert_select 'td', 'IP Address'
      end
    end
  end
end
