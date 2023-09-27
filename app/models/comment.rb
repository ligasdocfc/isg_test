# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :name, :comment, presence: true

  belongs_to :post
end
