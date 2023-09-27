# frozen_string_literal: true

module Comments
  class CommentBlueprint < Blueprinter::Base
    identifier :id

    fields :name, :comment

    association :post, blueprint: Posts::PostBlueprint
  end
end
