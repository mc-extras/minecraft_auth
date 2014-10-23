require 'test/unit'
require 'minecraft_auth'

class AccountTest < Test::Unit::TestCase
  def test_failure
    assert_raise MinecraftAuth::AccountError do
      MinecraftAuth.account('BadUser', 'BadPassword')
    end
  end

  def test_uuid
    assert_equal "2d5aa9cdaeb049189930461fc9b91cc5", MinecraftAuth.username_to_uuid('Jake0oo0')
  end

  def test_bad_uuid
    assert_nil MinecraftAuth.username_to_uuid('DoesNotExistUser')
  end

  # This can be tested if necessary, otherwise credentials should remain private.
  # def test_valid
  #   assert_raise MinecraftAuth::AccountError do
  #     MinecraftAuth.account('GoodUser', 'GoodPassword')
  #   end
  # end
end