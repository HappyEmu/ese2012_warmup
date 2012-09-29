module Store
  class User
    attr_accessor :name, :credits, :items

    def initialize
      self.name = ""
      self.credits = 100
      self.items = Array.new # AK prefer `[]`, the empty array literal.
    end

    def self.named(name)
      user = User.new
      user.name = name
      return user
    end

    def propose_item(name, price)
      item = Item.named_priced_with_owner(name, price, self)
      self.items.push(item) # AK there is also `items << item`
      return item
    end

    def get_active_items
      # AK In ruby, you call your accessors by the attribute name e.g.
      #
      # def get_active_items      => def active_items
      # def set_active_items(arg) => def active_items=(arg)
      active_items = Array.new
      self.items.each do |item|
        if item.active == true # AK you don't need to check for equality in bools
          active_items.push(item) # everything except `false` and `nil` is true
        end
      end
      # AK This is a common pattern, so there is a method for this:
      #active_items.select {|i| i.active?}

      return active_items 
    end

    def add_item(item)
      self.items.push(item)
      item.owner = self
    end

    def remove_item(item)
      if self.items.include?(item)
        item.owner = nil
        self.items.delete(item)
      end
    end

    def buy_item(item)
      seller = item.owner

      # it is common to invert the early-return conditions
      if seller.nil?
        return false, "Item does not belong to anybody"
      elsif self.credits < item.price
        return false, "Buyer does not have enough credits"
      elsif !item.active?
        return false, "Trying to buy inactive item"
      elsif !seller.items.include?(item)
        return false, "Seller does not own item to buy"
      end
      
      # AK like this:
      return false, "..." if seller.nil?
      return false, "..." if credits < item.price
      return false, "..." if not item.active?
      return false, "..." if not seller.items.include? item

      # but actually, you probably want to make this an error:

      fail "..." if seller.nil?
      fail "..." if credits < item.price
      fail "..." if not item.active?
      fail "..." if not seller.items.include? item

      seller.remove_item(item)
      seller.credits += item.price

      item.owner = self
      item.active = false

      self.add_item(item)
      self.credits -= item.price

      return true, "Transaction successful"
    end

    def to_s
      return "#{self.name}, #{self.credits}"
    end
  end
end
