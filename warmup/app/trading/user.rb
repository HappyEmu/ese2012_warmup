module Trading
  class User
    attr_accessor :name, :credits, :items

    def initialize
      self.name = ""
      self.credits = 100
      self.items = Array.new
    end

    def self.named(name)
      user = User.new
      user.name = name
      return user
    end

    def create_item(name, price)
      item = Item.named_priced_with_owner(name, price, self)
      self.items.push(item)
      return item
    end

    def show_active_items
      active_items = Array.new
      self.items.each do |item|
        if (item.active)
          active_items.push(item)
        end
      end

      return active_items
    end

    def add_item(item)
      self.items.push(item)
      item.owner = self
    end

    def remove_item(item)
      if (self.items.include? item)
        item.owner = nil
        self.items.delete(item)
      end
    end

    def buy_item(item)
      # check for moneys and activity first
      seller = item.owner

      if (!seller.nil?)
        seller.remove_item(item)
        seller.credits += item.price
      end

      item.owner = self
      item.active = false
      self.add_item(item)
      self.credits -= item.price

      # maybe return boolean for success
    end

    def to_s
      return "#{self.name}, #{self.credits}"
    end
  end
end
