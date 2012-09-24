require 'test/unit'
require '../app/trading/item'

class ItemTest < Test::Unit::TestCase
  def test_item
    item = Trading::Item.named_priced_with_owner("Test", 100, nil)
    item.set_price(200)
    puts item.to_s
    assert(item.price == 180, "Wrong Price!")
  end
end