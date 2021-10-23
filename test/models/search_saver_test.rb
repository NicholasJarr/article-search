require "test_helper"

class SearchSaverTest < ActiveSupport::TestCase
    def setup
    end

    test "should create a new Search if there is no search like it recently" do
        query = "what is this?"
        ip_address = "127.0.0.1"
        saver = SearchSaver.new query, ip_address

        assert_difference "Search.count", 1 do
            saver.save
        end

        query = "how this is possible?"
        ip_address = "127.0.0.1"
        saver = SearchSaver.new query, ip_address

        assert_difference "Search.count", 1 do
            saver.save
        end
    end

    test "should update a recent Search if there is a search equal to it recently" do
        query = "what is this?"
        ip_address = "127.0.0.1"
        saver = SearchSaver.new query, ip_address

        previous_search = nil
        assert_difference "Search.count", 1 do
            previous_search = saver.save
        end

        query = "what is this?"
        ip_address = "127.0.0.1"
        saver = SearchSaver.new query, ip_address

        new_search = nil
        assert_no_difference "Search.count" do
            new_search = saver.save
        end

        assert previous_search.id == new_search.id
        assert new_search.updated_at > previous_search.updated_at
    end

    test "should update a recent Search if there is a search like it recently" do
        query = "what is this?"
        ip_address = "127.0.0.1"
        saver = SearchSaver.new query, ip_address

        previous_search = nil
        assert_difference "Search.count", 1 do
            previous_search = saver.save
        end

        query = "what is that?"
        ip_address = "127.0.0.1"
        saver = SearchSaver.new query, ip_address

        new_search = nil
        assert_no_difference "Search.count" do
            new_search = saver.save
        end

        assert previous_search.id == new_search.id
        assert new_search.updated_at > previous_search.updated_at
        assert new_search.query == query
    end

    test "should work properly with similar queries" do
        search = nil
        assert_difference "Search.count", 1 do
            SearchSaver.new("What is", "127.0.0.1").save
            SearchSaver.new("What is a", "127.0.0.1").save
            search = SearchSaver.new("What is a good car?", "127.0.0.1").save
        end
        search.delete

        search = nil
        assert_difference "Search.count", 1 do
            SearchSaver.new("How is", "127.0.0.1").save
            SearchSaver.new("Howis emil hajric", "127.0.0.1").save
            search = SearchSaver.new("How is emil hajric doing?", "127.0.0.1").save
        end
        search.delete

        search = nil
        assert_difference "Search.count", 1 do
            SearchSaver.new("How is", "127.0.0.1").save
            SearchSaver.new("Howis emil hajric", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doing?", "127.0.0.1").save
            search = SearchSaver.new("How is emil", "127.0.0.1").save
        end
        search.delete

        search = nil
        assert_difference "Search.count", 1 do
            SearchSaver.new("hello", "127.0.0.1").save
            SearchSaver.new("hello world", "127.0.0.1").save
            search = SearchSaver.new("hello world how are you?", "127.0.0.1").save
        end
        search.delete

        search = nil
        assert_difference "Search.count", 1 do
            SearchSaver.new("H", "127.0.0.1").save
            SearchSaver.new("Ho", "127.0.0.1").save
            SearchSaver.new("How", "127.0.0.1").save
            SearchSaver.new("How ", "127.0.0.1").save
            SearchSaver.new("How i", "127.0.0.1").save
            SearchSaver.new("How is", "127.0.0.1").save
            SearchSaver.new("How is ", "127.0.0.1").save
            SearchSaver.new("How is e", "127.0.0.1").save
            SearchSaver.new("How is em", "127.0.0.1").save
            SearchSaver.new("How is emi", "127.0.0.1").save
            SearchSaver.new("How is emil", "127.0.0.1").save
            SearchSaver.new("How is emil ", "127.0.0.1").save
            SearchSaver.new("How is emil h", "127.0.0.1").save
            SearchSaver.new("How is emil ha", "127.0.0.1").save
            SearchSaver.new("How is emil haj", "127.0.0.1").save
            SearchSaver.new("How is emil hajr", "127.0.0.1").save
            SearchSaver.new("How is emil hajri", "127.0.0.1").save
            SearchSaver.new("How is emil hajric", "127.0.0.1").save
            SearchSaver.new("How is emil hajric ", "127.0.0.1").save
            SearchSaver.new("How is emil hajric d", "127.0.0.1").save
            SearchSaver.new("How is emil hajric do", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doi", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doin", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doing", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doing?", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doing", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doin", "127.0.0.1").save
            SearchSaver.new("How is emil hajric doi", "127.0.0.1").save
            SearchSaver.new("How is emil hajric do", "127.0.0.1").save
            SearchSaver.new("How is emil hajric d", "127.0.0.1").save
            SearchSaver.new("How is emil hajric ", "127.0.0.1").save
            SearchSaver.new("How is emil hajric", "127.0.0.1").save
            SearchSaver.new("How is emil hajri", "127.0.0.1").save
            SearchSaver.new("How is emil hajr", "127.0.0.1").save
            SearchSaver.new("How is emil haj", "127.0.0.1").save
            SearchSaver.new("How is emil ha", "127.0.0.1").save
            SearchSaver.new("How is emil h", "127.0.0.1").save
            SearchSaver.new("How is emil ", "127.0.0.1").save
            SearchSaver.new("How is emil", "127.0.0.1").save
            SearchSaver.new("How is emi", "127.0.0.1").save
            SearchSaver.new("How is em", "127.0.0.1").save
            SearchSaver.new("How is e", "127.0.0.1").save
            SearchSaver.new("How is ", "127.0.0.1").save
            SearchSaver.new("How is", "127.0.0.1").save
            SearchSaver.new("How i", "127.0.0.1").save
            SearchSaver.new("How ", "127.0.0.1").save
            SearchSaver.new("How", "127.0.0.1").save
            SearchSaver.new("Ho", "127.0.0.1").save
            search = SearchSaver.new("H", "127.0.0.1").save
        end
        search.delete
    end
end