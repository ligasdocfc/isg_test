# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, :text, presence: true

  belongs_to :user
end
