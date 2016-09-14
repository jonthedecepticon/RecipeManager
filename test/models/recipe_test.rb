require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create(chefname: "Jon", email: "jon@example.com")
    @recipe = @chef.recipes.build(name: "Chicken Noodle Soup", summary: "This is chicken noodle soup", description: "Add water and cook for 20 min.")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "ensure chef_id with recipe" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "name length should not be too long" do
    @recipe.name = "a" * 101
    assert_not = @recipe.valid?
  end

  test "name length should not be too short" do
    @recipe.name = "1234"
    assert_not = @recipe.valid?
  end

  test "summary must be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end

  test "summary length should not be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end

  test "summary length should not be too short" do
    @recipe.summary = "1234"
    assert_not @recipe.valid?
  end

  test "description must be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end
end
