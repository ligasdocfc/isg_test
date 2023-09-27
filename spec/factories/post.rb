# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Name.name }
    text { Faker::Quote.jack_handey }
  end
end
