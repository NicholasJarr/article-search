class SearchesController < ApplicationController
    def index
        @ip_addresses = Search.ip_addresses.map { |s| s.ip_address }
        @ip_address = params[:ip_address] ? params[:ip_address] : @ip_addresses.first
        @searches = Search.where(ip_address: @ip_address)
    end
end
