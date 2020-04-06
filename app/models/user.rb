# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, presence: true,
                   uniqueness: { case_sensetive: false },
                   length: { in: 3..15 },
                   allow_blank: false

  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensetive: false },
                    format: { with: EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
end
