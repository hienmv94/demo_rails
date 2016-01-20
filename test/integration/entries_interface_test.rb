require 'test_helper'

class entriesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "Entry interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Entry.count' do
      post entries_path, Entry: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This Entry really ties the room together"
    assert_difference 'Entry.count', 1 do
      post entries_path, Entry: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_Entry = @user.entries.paginate(page: 1).first
    assert_difference 'Entry.count', -1 do
      delete Entry_path(first_Entry)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end