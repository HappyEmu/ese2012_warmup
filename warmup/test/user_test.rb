require 'test/unit'
require '../app/store/user'
require '../app/store/item'

class UserTest < Test::Unit::TestCase
  def test_check_user_name
    name = "Hansli Caramell"
    user = Store::User.named(name)

    assert(!user.name.nil? ,"No User Name")
    assert(user.name == name, "Wrong User name")

  end

  def test_default_credits_amount
    default_amount = 100
    user = Store::User.new

    assert(user.credits == default_amount)
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

    item2.set_active
    item4.set_active

    active_items = [item2, item4]
    active_items_user = user.get_active_items

    # '==' operator of Array class tests for equal length and matching elements
    assert(active_items == active_items_user, "Item lists do not match!")
  end

  def test_user_buy_success
    buyer = Store::User.named("buyer")
    seller = Store::User.named("seller")

    item = seller.create_item("piece of crap", 100)
    item.set_active
    assert(buyer.buy_item(item) == true, "transaction failed")
    assert(buyer.credits == 0, "Buyer has too many credits left")
    assert(seller.credits == 200, "Seller has too few credits")
    assert(!seller.items.include?(item), "Seller still owns the sold item")
    assert(!item.active?, "Item is still active")
    assert(item.owner == buyer, "Item has the wrong owner")
    assert(buyer.items.include?(item), "buyer doesn't have the item")
  end

  def test_user_buy_inactive_item
    buyer = Store::User.named("buyer")
    seller = Store::User.named("seller")

    item = seller.create_item("piece of crap", 100)

    assert(!item.active?)
    assert(buyer.buy_item(item)==false,"the transaction should have failed but it did not")

    assert(buyer.credits == 100, "transaction succeeded")
    assert(seller.credits == 100, "transaction succeeded")
    assert(seller.items.include?(item), "Seller does not own the item")
    assert(!item.active?, "Item is active")
    assert(item.owner == seller, "Item has the wrong owner")
    assert(!buyer.items.include?(item), "buyer bought the item")
  end

  def test_user_buy_too_expensive
    buyer = Store::User.named("buyer")
    seller = Store::User.named("seller")

    item = seller.create_item("big piece of crap", 9001)
    item.set_active

    assert(item.active?, "item is inactive")
    assert(buyer.buy_item(item)==false,"the transaction should have failed but it did not")

    assert(buyer.credits == 100, "transaction succeeded")
    assert(seller.credits == 100, "transaction succeeded")
    assert(seller.items.include?(item), "Seller does not own the item")
    assert(item.owner == seller, "Item has the wrong owner")
    assert(!buyer.items.include?(item), "buyer bought the item")
  end
end