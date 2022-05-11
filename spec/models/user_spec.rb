require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context "given a user with email, fname, lname, password, password_confirmation" do
      it "is valid" do
        user = User.new({
          email: "test@test.com",
          fname: "John",
          lname: "Doe",
          password: "password123!",
          password_confirmation: "password123!"

        })
        user.save
        expect(user).to be_valid
      end
    end

  end
end
