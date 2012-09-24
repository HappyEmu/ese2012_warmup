module University
  class Item
    attr_accessor :name, :price, :owner, :active

    def initialize
      self.active = false
      self.owner = nil
    end

    def self.named_with_price(name, price)
      item = Item.new
      item.name = name
      item.price = price
      return item
    end

  end
end
