require "test_helper"

class SearchesIndexTest < ActionDispatch::IntegrationTest
  test "should show table with all searches if there is no ip filter" do
    get searches_path
    assert_response :success

    assert_select 'table' do
      assigns(:searches).each do |search|
        assert_select 'tr', id: search.id do
          assert_select 'td', search.query
          assert_select 'td', search.ip_address
        end
      end
    end
  end
end
