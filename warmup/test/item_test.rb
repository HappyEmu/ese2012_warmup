require 'test/unit'
require '../app/trading/item'

class ItemTest < Test::Unit::TestCase
  def test_item
    item = Trading::Item.named_priced_with_owner("Test", 100, nil)
    puts item.to_s
  end
end