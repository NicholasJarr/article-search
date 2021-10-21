class Article < ApplicationRecord
    BODY_MAX_LENGTH = 500

    validates :title, presence: true
    validates :body, presence: true, length: { maximum: BODY_MAX_LENGTH }

    scope :has_keyword, ->(search) { where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{search}%") }
end
