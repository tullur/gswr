# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 3 },
                    allow_blank: false
  validates :body, presence: true,
                   length: { in: 5..100 },
                   allow_blank: false

  scope :author, ->(username) { where(user: User.where(username: username)) }
  scope :search, ->(title) { where('title LIKE ?', "%#{title}%") }
end
