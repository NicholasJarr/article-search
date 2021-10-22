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
    get root_path query: "foo"
    assert_response :success

    assert_select 'input[name=query]', value: "foo"
    assert_select 'section#search_results' do
      assert_select 'ul' do
        assert_select 'li', count: 2
        assigns(:articles).each do |article|
          assert_select 'li', text: article.title
        end
      end
    end
  end
end
