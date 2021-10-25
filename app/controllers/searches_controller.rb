class SearchesController < ApplicationController
    def index
        @ip_addresses = Search.ip_addresses.map { |s| s.ip_address }

        # Use ip_address from params, or gets first unique ip address from DB if params is empty
        @ip_address = params[:ip_address] ? params[:ip_address] : @ip_addresses.first

        @searches = Search.where(ip_address: @ip_address)
    end
end
