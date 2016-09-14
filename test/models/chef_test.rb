require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "Jon", email: "jon@example.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chef name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chef name should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chef name should not be too short" do
    @chef.chefname = "12"
    assert_not @chef.valid?
  end

  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "example.com"
    assert_not @chef.valid?
  end

  test "email address should be uniq" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email address should be valid" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |valid_address|
      @chef.email = valid_address
      assert @chef.valid?, '#{valid_address.inspect} should be valid.'
    end
  end

  test "invalid email address should be rejected" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |invalid_address|
      @chef.email = invalid_address
      assert_not @chef.valid?, '#{invalid_address.inspect} should be invalid.'
    end
  end
end
