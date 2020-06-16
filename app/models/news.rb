class News < ApplicationRecord
  has_many :endpoints, dependent: :destroy
end
