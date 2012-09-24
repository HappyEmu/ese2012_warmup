require 'test/unit'
require '../app/trading/user'

class UserTest < Test::Unit::TestCase
  def test_user
    user = Trading::User.named("Hans")
    puts user.to_s
  end
end