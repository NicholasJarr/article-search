require "test_helper"

class ArticleCreationTest < ActionDispatch::IntegrationTest
  test "should work for valid articles" do
    get new_article_path
    assert_response :success

    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'Title',
                                                body: 'body' } }
    end

    follow_redirect!

    assert_template 'articles/index'
    assert_response :success

    assert flash[:success]
    assert_select '#alert_container > div', count: 1
  end

  test "should fail for invalid articles and show errors" do
    get new_article_path
    assert_response :success

    assert_no_difference 'Article.count', 0 do
      post articles_path, params: { article: { title: '',
                                                body: '' } }
    end

    assert_template 'articles/new'
    assert_response :success

    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'

    assert_no_difference 'Article.count', 0 do
      post articles_path, params: { article: { title: 'title',
                                                body: '' } }
    end

    assert_template 'articles/new'
    assert_response :success

    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'

    assert_no_difference 'Article.count', 0 do
      post articles_path, params: { article: { title: '',
                                                body: 'body' } }
    end

    assert_template 'articles/new'
    assert_response :success

    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'

    assert_no_difference 'Article.count', 0 do
      post articles_path, params: { article: { title: 'title',
                                                body: 'a' * 1000 } }
    end

    assert_template 'articles/new'
    assert_response :success

    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
end
