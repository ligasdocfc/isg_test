# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_attributes) do
    {
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    }
  end

  it 'creates a new user' do
    user = User.create(user_attributes)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user_attributes[:email] = nil
    user = User.create(user_attributes)
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user_attributes[:password] = nil
    user = User.create(user_attributes)
    expect(user).not_to be_valid
  end

  it 'is not valid with a short password' do
    user_attributes[:password] = 'short'
    user = User.create(user_attributes)
    expect(user).not_to be_valid
  end

  it 'authenticates a user with valid credentials' do
    user = User.create(user_attributes)
    authenticated_user = User.find_for_database_authentication(email: user.email)
    expect(authenticated_user.valid_password?('password123')).to be true
  end

  it 'does not authenticate a user with invalid password' do
    user = User.create(user_attributes)
    authenticated_user = User.find_for_database_authentication(email: user.email)
    expect(authenticated_user.valid_password?('wrongpassword')).to be false
  end
end
