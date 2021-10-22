class SearchesController < ApplicationController
    def index
        @searches = Search.all
    end
end
