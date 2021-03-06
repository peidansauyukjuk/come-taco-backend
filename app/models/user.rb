# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  has_many :orders
  has_many :items, through: :orders
  has_many :charges
end
