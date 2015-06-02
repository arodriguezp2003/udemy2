require 'test_helper'

class ChefTest < ActiveSupport::TestCase

    def setup
        @chef = Chef.new(chefname: "Alejandro Rodriguez Peña", email: "alejandrorodriguezpena@gmail.com")
    end
    
    test "chef must be valid" do
        assert @chef.valid?
    end
    
    test "cherfname should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end
    
    test "chefname hsould not be to long" do
        @chef.chefname = "a" * 41
        assert_not @chef.valid?
    end
    test "chefname hsould not be to short" do
        @chef.chefname = "aa"  
        assert_not @chef.valid?
    end   
    
    test "Email should be present" do 
        @chef.email = " "
        assert_not @chef.valid?
    end
    
    test "email length should be within bounds" do
        @chef.email = "a" * 101 + "@example.com"
        assert_not @chef.valid?
    end
    
    test "email adress should be unique" do
         dup_chef = @chef.dup
         dup_chef.email = @chef.email.upcase
         @chef.save
         assert_not dup_chef.valid?
    end
    
    test "email validation should accept valid address" do
        valid_address = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@mink.com]
        valid_address.each do |val|
            @chef.email = val 
            assert @chef.valid?, '#{val.inspect} should be valid'
        end
        
    end
    test "email validation should reject invalid address" do
        invalid_address = %w[user@eee,com user_at_ee.org foo@ee+arr.com]
        invalid_address.each do |a|
            @chef.email = a
            assert_not @chef.valid?, '#{a.inspect} should be invalid'
        end
    end
    
end
