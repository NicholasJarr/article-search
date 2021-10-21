require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    # TODO: Use fixture here
    # TODO: Make tests organized like search tests
    @article = Article.new title: "Title", body: "body"
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "should be invalid" do
    invalid_article = Article.new title: "", body: "body"
    assert_not invalid_article.valid?

    invalid_article = Article.new title: "title", body: ""
    assert_not invalid_article.valid?

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
