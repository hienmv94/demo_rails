require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @entry = @user.entries.build(content: "first content")
    @comment =@entry.build(content: "fisrt comment")
    # @entry = entry.new(content: "first content", user_id: @user.id)
  end

  test  "should be valid" do
    assert @comment.valid?
  end
  
  test "user is should be present" do
    @comment.user_id = nil
    assert_not @entry.valid?
  end

  test "content should be present" do
    @comment.content = "   "
    assert_not @entry.valid?
  end

  test "content should be at most 140 characters" do
    @comment.content = "a" * 141
    assert_not @entry.valid?
  end

  test "order should be most recent first" do 
    assert_equal comments(:most_recent), comment.first
  end
end
