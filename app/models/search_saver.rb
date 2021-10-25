# Here is where the main algorithm of the app is.
# Basically the algorithms assigns a percentage of similarity between two queries, and
# checks the percentage relation with a threshold. Greater than threshold, it's considered
# similar; less than threhold, it's considered different
#
# The algorithm:
#   - Given two queries q1 and q2
#       - For each character in q1, it is searched in q2
#       - If it is found
#           - Checks the distance between the original index and the new
#           - Uses 2 ** -distance to create a scale (from 0 to 1) where smaller values
#             are further and bigger values are closer to original position
#           - If it is too far (closer to 0), disconsider it
#           - Otherwise, add value to score
#       - Otherwise, ignore character
#       - After loop is over, return what is the percentage of the final score in the query length
# There is also a black list to prevent from finding repeated characters
# Check the test cases on search_saver_test.rb for examples

class SearchSaver
    SIMILARITY_THRESHOLD = 0.5

    def initialize(query, ip_address)
        @query = query
        @ip_address = ip_address
    end

    def save
        recent_search = Search.first
        if recent_search && is_query_similar(recent_search.query.downcase, @query.downcase)
            recent_search.query = @query
            if recent_search.query == @query
                recent_search.updated_at = DateTime.now
            end
            recent_search.save!
            return recent_search
        end

        Search.create! query: @query, ip_address: @ip_address
    end

    private
        def is_query_similar(query1, query2)
            return query_score(query1, query2) > SIMILARITY_THRESHOLD
        end

        def query_score(query1, query2)
            score = 0
            index_black_list = []
            query1.each_char.with_index do |c, i|
                if index_black_list.length == query2.length
                    break
                end

                i2 = find_index query2, query1[i], index_black_list
                if not i2
                    next 
                end

                index_black_list.append i2

                dist = 2 ** -(i - i2).abs
                if dist >= 0.01
                    score += dist
                end
            end

            length = if query1.length < query2.length then query1.length else query2.length end
            score.to_f / length
        end

        def find_index(str, target, index_black_list = [])
            skip = 0
            loop do
                i = str[skip..-1].index target
                if not i
                    return nil 
                end

                i += skip
                if not index_black_list.include? i
                    return i
                end

                skip = i + 1
                if skip >= str.length
                    return nil 
                end
            end
        end
end