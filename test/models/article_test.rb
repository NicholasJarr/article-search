require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
  end

  test "should be valid" do
    article = Article.new title: "Title", body: "body"
    assert article.valid?
  end

  test "title must be present" do
    invalid_article = Article.new title: "", body: "body"
    assert_not invalid_article.valid?
  end

  test "body must be present" do
    invalid_article = Article.new title: "title", body: ""
    assert_not invalid_article.valid?
  end

  test "body must be less than maximum length" do
    invalid_article = Article.new title: "title", body: 'a' * 1000
    assert_not invalid_article.valid?
  end

  test "has_keyword should work properly" do
    # Search between the fixtures; check fixtures for available search targets
    assert Article.has_keyword("foo").count == 2
    assert Article.has_keyword("bar").count == 2
    assert Article.has_keyword("baz").count == 3
    assert Article.has_keyword("qux").count == 1
  end
end
