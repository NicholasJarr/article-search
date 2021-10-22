require "test_helper"

class SearchTest < ActiveSupport::TestCase
  def setup
  end

  test "should be valid" do
    search = Search.new query: "What is this?", ip_address: "192.168.0.1"
    assert search.valid?

    search = Search.new query: "What is this?", ip_address: "0.0.0.0"
    assert search.valid?

    search = Search.new query: "What is this?", ip_address: "55.55.55.55"
    assert search.valid?

    search = Search.new query: "What is this?", ip_address: "192.168.100.1"
    assert search.valid?

    search = Search.new query: "What is this?", ip_address: "192.168.100.55"
    assert search.valid?
  end

  test "query must be present" do
    search = Search.new query: "", ip_address: "192.168.0.1"
    assert_not search.valid?
  end

  test "ip_address must be present" do
    search = Search.new query: "Query", ip_address: ""
    assert_not search.valid?
  end

  test "ip_address must be valid" do
    search = Search.new query: "Query", ip_address: "ip address"
    assert_not search.valid?

    search = Search.new query: "Query", ip_address: "1.a.b.3"
    assert_not search.valid?

    search = Search.new query: "Query", ip_address: "192.168.0.10.120.1"
    assert_not search.valid?

    search = Search.new query: "Query", ip_address: "1920.1683121.0.10.120.1"
    assert_not search.valid?

    search = Search.new query: "Query", ip_address: "...."
    assert_not search.valid?
  end

  test "ip_addresses scope should work properly" do
    # Search between the fixtures; check fixtures for available search targets
    assert Search.ip_addresses.count == 2
  end
end
