require 'test_helper'

class PrizesControllerTest < ActionController::TestCase
  setup do
    @prize = prizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prize" do
    assert_difference('Prize.count') do
      post :create, prize: { amount: @prize.amount, description: @prize.description, status: @prize.status, type: @prize.type, winner: @prize.winner }
    end

    assert_redirected_to prize_path(assigns(:prize))
  end

  test "should show prize" do
    get :show, id: @prize
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prize
    assert_response :success
  end

  test "should update prize" do
    patch :update, id: @prize, prize: { amount: @prize.amount, description: @prize.description, status: @prize.status, type: @prize.type, winner: @prize.winner }
    assert_redirected_to prize_path(assigns(:prize))
  end

  test "should destroy prize" do
    assert_difference('Prize.count', -1) do
      delete :destroy, id: @prize
    end

    assert_redirected_to prizes_path
  end
end
