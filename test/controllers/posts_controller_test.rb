require 'test_helper'

class PostsControllerTest < ActionController::TestCase

    test "should redirect to show with alert if no current user" do
      get :edit, id:  post = posts(:one).id
      assert_redirected_to post_path(posts(:one))
      assert_equal 'You must be logged in to edit posts', flash[:alert]
    end

  test "should redirect to show with alert if editing post current user did not author" do

    session[:current_user_id] = users(:two).id
    
   get :edit, id:  post = posts(:one).id
    
    assert_response :redirect
    assert_redirected_to post_path(posts(:one))
    assert_equal 'You can only edit your own posts', flash[:alert]
  end
end