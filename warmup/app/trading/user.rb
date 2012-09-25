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
    end

    def show_active_items
      out_string = ""
      self.items.each { |item| out_string < "#{item}\n"}

      return out_string
    end

    def add_item(item)
      self.items.push(item)
    end

    def take_credits(amount)
      self.credits -= amount
    end

    def give_credits(amount)
      self.credits += amount
    end

    def to_s
      return "#{self.name}, #{self.credits}"
    end
  end
end
