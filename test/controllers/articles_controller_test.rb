require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success

    assert_select 'input#search'
    assert_select 'a[href=?]', new_article_path
    assert_select 'button[type=submit]'
  end

  test "should get new" do
    get new_article_path
    assert_response :success
  end
end
