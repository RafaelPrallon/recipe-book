require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has an attachment" do
    assert_has_one_attached :avatar
  end
end
