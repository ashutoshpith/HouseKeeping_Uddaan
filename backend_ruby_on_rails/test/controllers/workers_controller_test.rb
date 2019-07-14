require 'test_helper'

class WorkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @worker = workers(:one)
  end

  test "should get index" do
    get workers_url, as: :json
    assert_response :success
  end

  test "should create worker" do
    assert_difference('Worker.count') do
      post workers_url, params: { worker: { admin_id: @worker.admin_id, name: @worker.name, skill_set: @worker.skill_set } }, as: :json
    end

    assert_response 201
  end

  test "should show worker" do
    get worker_url(@worker), as: :json
    assert_response :success
  end

  test "should update worker" do
    patch worker_url(@worker), params: { worker: { admin_id: @worker.admin_id, name: @worker.name, skill_set: @worker.skill_set } }, as: :json
    assert_response 200
  end

  test "should destroy worker" do
    assert_difference('Worker.count', -1) do
      delete worker_url(@worker), as: :json
    end

    assert_response 204
  end
end
