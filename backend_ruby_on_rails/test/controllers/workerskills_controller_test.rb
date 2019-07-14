require 'test_helper'

class WorkerskillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workerskill = workerskills(:one)
  end

  test "should get index" do
    get workerskills_url, as: :json
    assert_response :success
  end

  test "should create workerskill" do
    assert_difference('Workerskill.count') do
      post workerskills_url, params: { workerskill: { name: @workerskill.name, skill_set: @workerskill.skill_set } }, as: :json
    end

    assert_response 201
  end

  test "should show workerskill" do
    get workerskill_url(@workerskill), as: :json
    assert_response :success
  end

  test "should update workerskill" do
    patch workerskill_url(@workerskill), params: { workerskill: { name: @workerskill.name, skill_set: @workerskill.skill_set } }, as: :json
    assert_response 200
  end

  test "should destroy workerskill" do
    assert_difference('Workerskill.count', -1) do
      delete workerskill_url(@workerskill), as: :json
    end

    assert_response 204
  end
end
