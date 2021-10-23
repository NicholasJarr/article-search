require "test_helper"

class ArticlesIndexTest < ActionDispatch::IntegrationTest
  test "should show list with all article if there is no query" do
    get root_path
    assert_response :success

    assert_select 'section#search_results' do
      assert_select 'ul' do
        assigns(:articles).each do |article|
          assert_select 'li #title', text: article.title
          assert_select 'li #body', text: article.body
        end
      end
    end
  end

  test "should return list with all articles if there is no query, and request is for json" do
    get root_path, headers: { 'Accept' => 'application/json'}
    assert_response :success

    body = JSON.parse(response.body)
    assert body.count == assigns(:articles).count

    assigns(:articles).each do |article|
      body_article = body.find { |a| a['id'] == article.id }

      assert body_article
      assert body_article["title"] == article.title
      assert body_article["body"] == article.body
    end
  end

  test "should show list with filtered articles if there is a query" do
    query = "baz"

    get root_path query: query
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
          assert_select 'li #title', text: article.title
          assert_select 'li #body', text: article.body

          assert article.title.include?(query) || article.body.include?(query)
        end
      end
    end
  end

  test "should return list with filtered articles if there is a query, and request is for json" do
    query = "baz"

    get root_path, params: { query: query }, headers: { 'Accept' => 'application/json'}
    assert_response :success

    body = JSON.parse(response.body)
    assert body.count == 3

    assigns(:articles).each do |article|
      body_article = body.find { |a| a['id'] == article.id }

      assert body_article
      assert body_article["title"] == article.title
      assert body_article["body"] == article.body
      assert body_article["title"].include?(query) || body_article["body"].include?(query)
    end
  end
end
