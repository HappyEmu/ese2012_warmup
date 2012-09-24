module Trading
  class User

    attr_accessor :name, :credits, :items

    def initialize
      self.credits = 100
      self.items = Array.new
    end

    def self.named(name)
      user = User.new
      user.name = name
      return name
    end

    def add_item(item)
      self.items.push(item)
    end

    def to_s
      return "#{self.name}, #{self.credits}, #{self.items}"
    end

  end
end