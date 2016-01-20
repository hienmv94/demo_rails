require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @entry = @user.entries.build(content: "first content")
  end

  test  "should be valid" do
    assert @entry.valid?
  end
  
  test "user is should be present" do
    @entry.user_id = nil
    assert_not @entry.valid?
  end

  test "content should be present" do
    @entry.content = "   "
    assert_not @entry.valid?
  end

  test "content should be at most 140 characters" do
    @entry.content = "a" * 141
    assert_not @entry.valid?
  end

  test "order should be most recent first" do 
    assert_equal entries(:most_recent), entry.first
  end
end
