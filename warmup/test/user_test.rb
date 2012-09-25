require 'test/unit'
require '../app/trading/user'
require '../app/trading/item'

class UserTest < Test::Unit::TestCase
  def test_user
    user = Trading::User.named("Hans")
    puts user.to_s
    item = user.create_item("Test Item", 500);
    active_items = user.show_active_items
    item.active = true
    active_items = user.show_active_items
  end
end