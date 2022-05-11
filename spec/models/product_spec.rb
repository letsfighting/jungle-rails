require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before do
      @category = Category.new({name: "Test"})
    end
    
    context "given product with valid attributes" do
    
      it "is valid" do
        product = Product.new({
          name: "Test",
          price: 123,
          category: @category,
          quantity: 1
        })
        product.save
        expect(product).to be_valid
      end
    end

    context "given product missing name" do
      it "is invalid" do
        product = Product.new({
          price: 123,
          category: @category,
          quantity: 1
        })
        product.save
        expect(product.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

    context "given product missing price" do
      it "is invalid" do
        product = Product.new({
          name: "Test",
          category: @category,
          quantity: 1
        })
        product.save
        expect(product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
      end
    end

    context "given product missing quantity" do
      it "is invalid" do 
        product = Product.new({
          name: "test",
          category: @category,
          price: 123

        })
        product.save
        expect(product.errors.full_messages).to eq(["Quantity can't be blank"])
      end
    end
      
     context "given product missing category" do
      it "is invalid" do 
        product = Product.new({
          name: "test",
          price: 123,
          quantity: 1
        })
        product.save
        expect(product.errors.full_messages).to eq(["Category must exist", "Category can't be blank"])
      end
    end


  end
end
