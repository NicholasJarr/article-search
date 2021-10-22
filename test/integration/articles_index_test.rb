require "test_helper"

class ArticlesIndexTest < ActionDispatch::IntegrationTest
  test "should show list with all article if there is no query" do
    get root_path
    assert_response :success

    assert_select 'section#search_results' do
      assert_select 'ul' do
        assigns(:articles).each do |article|
          assert_select 'li', text: article.title
        end
      end
    end
  end

  test "should show list with filtered article if there is a query" do
    get root_path query: "baz"
    assert_response :success

    # assert that there is a search with the current query
    search = Search.order(created_at: :desc).first
    assert_not_nil search
    assert search.query == "baz"
    assert_not_empty search.ip_address

    assert_select 'input[name=query]', value: "foo"
    assert_select 'section#search_results' do
      assert_select 'ul' do
        assert_select 'li', count: 3
        assigns(:articles).each do |article|
          assert_select 'li', text: article.title
        end
      end
    end
  end
end
