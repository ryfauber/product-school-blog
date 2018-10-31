require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    end

    assert_redirected_to post_path(@comment.post_id)
  end

  test "should get edit" do
    get :edit, id: @comment
    assert_response :success
  end

  test "should update comment" do
    patch :update, id: @comment, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    assert_redirected_to post_path(@comment.post)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to post_path(@comment.post)
  end
end
