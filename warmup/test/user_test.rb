require 'test/unit'
require '../app/trading/user'
require '../app/trading/item'

class UserTest < Test::Unit::TestCase
  def test_user
    user = Trading::User.named("Hans")
    puts user.to_s
    user.give_credits(20)
    user.create_item("Test Item", 500);
    puts user.items[0].to_s
    puts user.show_active_items

    assert(user.credits == 120)
    assert(user.credits == 120)
  end
end