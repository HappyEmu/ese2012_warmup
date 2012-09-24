module Trading
  class Item
    attr_accessor :name, :price, :owner, :active

    def initialize
      self.active = false
    end

    def self.named_priced_with_owner(name, price, owner)
      item = Item.new
      item.name = name
      item.price = price
      item.owner = owner
      return item
    end

    def to_s
      return "#{self.name}, #{self.price}, #{self.owner}, #{self.active}"
    end

    def set_price(price)
      self.price = price
    end

  end
end
