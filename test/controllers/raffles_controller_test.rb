require 'test_helper'

class RafflesControllerTest < ActionController::TestCase
  setup do
    @raffle = raffles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raffles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raffle" do
    assert_difference('Raffle.count') do
      post :create, raffle: { business_id: @raffle.business_id, end_date: @raffle.end_date, prize_id: @raffle.prize_id, status: @raffle.status, target_url: @raffle.target_url }
    end

    assert_redirected_to raffle_path(assigns(:raffle))
  end

  test "should show raffle" do
    get :show, id: @raffle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raffle
    assert_response :success
  end

  test "should update raffle" do
    patch :update, id: @raffle, raffle: { business_id: @raffle.business_id, end_date: @raffle.end_date, prize_id: @raffle.prize_id, status: @raffle.status, target_url: @raffle.target_url }
    assert_redirected_to raffle_path(assigns(:raffle))
  end

  test "should destroy raffle" do
    assert_difference('Raffle.count', -1) do
      delete :destroy, id: @raffle
    end

    assert_redirected_to raffles_path
  end
end
