# frozen_string_literal: true

module Posts
  class PostBlueprint < Blueprinter::Base
    identifier :id

    fields :title, :text

    association :user, blueprint: Users::UserBlueprint
  end
end
