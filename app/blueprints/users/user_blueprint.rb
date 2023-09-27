# frozen_string_literal: true

module Users
  class UserBlueprint < Blueprinter::Base
    identifier :id

    fields :name, :email
  end
end
