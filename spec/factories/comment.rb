# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    name { Faker::Name.name }
    comment { Faker::Quote.jack_handey }
  end
end
