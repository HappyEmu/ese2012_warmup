require 'test/unit'
require '../app/store/user'
require '../app/store/item'

class UserTest < Test::Unit::TestCase
  def test_check_user_name
    name = "Hansli Caramell"
    user = Store::User.named(name)

    assert(user.name == name, "Wrong User name")
  end

  def test_default_credits_amount
    amount = 100
    user = Store::User.new

    assert(user.credits == amount)
  end

  def test_custom_credits_amount
    amount = 123
    user = Store::User.new
    user.credits = amount

    assert(user.credits == amount)
  end

  def test_user_creates_item
    user = Store::User.named("User")
    item = user.create_item("TestItem", 100)

    assert(item.active == false, "Newly created items must be inactive!")
    assert(item.owner == user, "Item with no assigned owner created!")
  end

  def test_user_active_items_list
    user = Store::User.named("User")

    item1 = user.create_item("TestItem1", 1)
    item2 = user.create_item("TestItem2", 2)
    item3 = user.create_item("TestItem3", 3)
    item4 = user.create_item("TestItem4", 4)

    user.add_item(item1)
    user.add_item(item2)
    user.add_item(item3)
    user.add_item(item4)

    item2.set_active
    item4.set_active

    active_items = [item2, item4]
    active_items_user = user.get_active_items

    assert(active_items.length == active_items_user.length)
    end
end