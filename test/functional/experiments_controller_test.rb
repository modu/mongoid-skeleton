require 'test_helper'

class ExperimentsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get created" do
    get :created
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get load" do
    get :load
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get updated" do
    get :updated
    assert_response :success
  end

  test "should get xml" do
    get :xml
    assert_response :success
  end

end
