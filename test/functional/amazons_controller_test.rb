require 'test_helper'

class AmazonsControllerTest < ActionController::TestCase
  setup do
    @amazon = amazons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amazons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amazon" do
    assert_difference('Amazon.count') do
      post :create, :amazon => @amazon.attributes
    end

    assert_redirected_to amazon_path(assigns(:amazon))
  end

  test "should show amazon" do
    get :show, :id => @amazon.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @amazon.to_param
    assert_response :success
  end

  test "should update amazon" do
    put :update, :id => @amazon.to_param, :amazon => @amazon.attributes
    assert_redirected_to amazon_path(assigns(:amazon))
  end

  test "should destroy amazon" do
    assert_difference('Amazon.count', -1) do
      delete :destroy, :id => @amazon.to_param
    end

    assert_redirected_to amazons_path
  end
end
