# frozen_string_literal: true

class CommentInput
  include ActiveModel::Validations

  validates :name, :comment, :post_id, presence: true

  attr_accessor :name, :comment, :post_id

  def initialize(comment_params)
    @name = comment_params[:name]
    @comment = comment_params[:comment]
    @post_id = comment_params[:post_id]
  end
end
