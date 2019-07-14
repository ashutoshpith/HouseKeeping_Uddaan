require 'test_helper'

class TitusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @titu = titus(:one)
  end

  test "should get index" do
    get titus_url, as: :json
    assert_response :success
  end

  test "should create titu" do
    assert_difference('Titu.count') do
      post titus_url, params: { titu: { age: @titu.age, name: @titu.name } }, as: :json
    end

    assert_response 201
  end

  test "should show titu" do
    get titu_url(@titu), as: :json
    assert_response :success
  end

  test "should update titu" do
    patch titu_url(@titu), params: { titu: { age: @titu.age, name: @titu.name } }, as: :json
    assert_response 200
  end

  test "should destroy titu" do
    assert_difference('Titu.count', -1) do
      delete titu_url(@titu), as: :json
    end

    assert_response 204
  end
end
