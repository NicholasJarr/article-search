class Search < ApplicationRecord
    validates :query, presence: true
    validates :ip_address, presence: true, format: {
        with: /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\Z/,
        message: " must be properly formatted"
    }
end
