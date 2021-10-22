class SearchesController < ApplicationController
    def index
        # TODO: Add pagination
        @searches = Search.all
    end
end
