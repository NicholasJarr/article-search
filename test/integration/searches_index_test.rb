require "test_helper"

class SearchesIndexTest < ActionDispatch::IntegrationTest
  test "should show table with first ip if there is no ip selected" do
    get searches_path
    assert_response :success

    selected_ip = Search.ip_addresses[0].ip_address
    assert_select 'section#table_filter' do
      assert_select 'form[action=?]', searches_path do
        assert_select 'select[name="ip_address"]' do
          assigns(:ip_addresses).each do |ip|
            assert_select 'option', ip, selected: ip == selected_ip
          end
        end
        assert_select 'button[type="submit"]'
      end
    end

    assert_select 'table' do
      assigns(:searches).each do |search|
        assert search.ip_address == selected_ip
        assert_select 'tr', id: search.id do
          assert_select 'td', search.query
          assert_select 'td', search.ip_address
        end
      end
    end
  end
  test "should show table with selected ip if there is an ip selected" do
    selected_ip = Search.ip_addresses[1].ip_address

    get searches_path ip_address: selected_ip
    assert_response :success

    assert_select 'section#table_filter' do
      assert_select 'form[action=?]', searches_path do
        assert_select 'select[name="ip_address"]' do
          assigns(:ip_addresses).each do |ip|
            assert_select 'option', ip, selected: ip == selected_ip
          end
        end
        assert_select 'button[type="submit"]'
      end
    end

    assert_select 'table' do
      assigns(:searches).each do |search|
        assert search.ip_address == selected_ip
        assert_select 'tr', id: search.id do
          assert_select 'td', search.query
          assert_select 'td', search.ip_address
        end
      end
    end
  end
end
