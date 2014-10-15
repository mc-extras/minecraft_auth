require 'test/unit'
require 'minecraft_auth'

class AccountTest < Test::Unit::TestCase
  def test_failure
    assert_raise MinecraftAuth::AccountError do
      MinecraftAuth.account('BadUser', 'BadPassword')
    end
  end

  # This can be tested if necessary, otherwise credentials should remain private.
  # def test_valid
  #   assert_raise MinecraftAuth::AccountError do
  #     MinecraftAuth.account('GoodUser', 'GoodPassword')
  #   end
  # end
end