class Article < ApplicationRecord
    TITLE_MAX_LENGTH = 100
    BODY_MAX_LENGTH = 500

    validates :title, presence: true, length: { maximum: TITLE_MAX_LENGTH }
    validates :body, presence: true, length: { maximum: BODY_MAX_LENGTH }

    default_scope { order created_at: :desc }
    scope :has_keyword, ->(search) { where("title LIKE :keyword OR body LIKE :keyword", keyword: "%#{search}%") }
end
