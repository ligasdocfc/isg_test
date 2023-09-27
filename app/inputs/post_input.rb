# frozen_string_literal: true

class PostInput
  include ActiveModel::Validations

  validates :title, :text, presence: true

  attr_accessor :title, :text

  def initialize(post_params)
    @title = post_params[:title]
    @text = post_params[:text]
  end
end
