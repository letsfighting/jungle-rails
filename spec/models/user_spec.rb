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

    context "given an email that is already in the database" do
      it "results in an error indicating the email was already used previously" do
        user1 = User.new({
          email: "test@test.com",
          fname: "Tom",
          lname: "Brady",
          password: "password123!",
          password_confirmation: "password123!"
        })
        user1.save
        expect(user1).to be_valid

        user2 = User.new({
          email: "test@test.com",
          fname: "Tom",
          lname: "Brady",
          password: "password123!",
          password_confirmation: "password123!"
        })
        user2.save
        expect(user2.errors.full_messages).to eq(["Email has already been taken"])

        user2 = User.new({
          email: "TEST@TEST.com",
          fname: "Tom",
          lname: "Brady",
          password: "password123!",
          password_confirmation: "password123!"
        })
        user2.save
        expect(user2.errors.full_messages).to eq(["Email has already been taken"])
      end
    end

    context "given a user with no fname" do
      it "is invalid and indicates that first name cannot be blank" do
        user = User.new({
          email: "TEST@TEST.com",

          lname: "Brady",
          password: "password123!",
          password_confirmation: "password123!"
        })
        user.save
        expect(user.errors.full_messages).to eq(["Fname can't be blank"])
      end
    end

    context "given a user with no last name" do
      it "is invalid and indicates that lname cannot be blank" do
        user = User.new ({
          email: "TEST@TEST.com",

          fname: "Brady",
          password: "password123!",
          password_confirmation: "password123!"
        })
        user.save
        expect(user.errors.full_messages).to eq(["Lname can't be blank"])
      end
    end

    context "given a user with unmatched password and password confirmation" do
      it "is not valid and indicates that the confirmation and password do not match" do
        user = User.new ({
         email: "TEST@TEST.com",
          fname: "Tom",
          lname: "Brady",
          password: "password123!",
          password_confirmation: "password1234!"
        })
        user.save
        expect(user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
      end
    end
    
  end
end
