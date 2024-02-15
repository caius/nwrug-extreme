require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get sum result" do
    get "/", params: { q: 'bullshit: what is 3 plus 7?' }
    assert_response :success
    assert_equal '10', @response.body
  end

  test "should get sum plus sum result" do
    get "/", params: { q: 'bullshit: what is 3 plus 7 plus 3?' }
    assert_response :success
    assert_equal '13', @response.body
  end

  test "should get minus result" do
    get "/", params: { q: 'bullshit: what is 3 minus 7?' }
    assert_response :success
    assert_equal '-4', @response.body
  end

  test "should get multiple minus result" do
    get "/", params: { q: 'bullshit: what is 3 minus 7 minus 3?' }
    assert_response :success
    assert_equal '-7', @response.body
  end

  test "should get largest number result" do
    get "/", params: { q: 'bullshit: which is the largest: 5, 9, or 3?' }
    assert_response :success
    assert_equal '9', @response.body
  end

  test "should get square/cube bullshit" do
    get "/", params: { q: 'bullshit: which of the following numbers is both a square and a cube: 100, 863, 1089, 718?' }
    assert_response :success
    assert_equal '', @response.body
  end

  test "should get power of" do
    get "/", params: { q: 'bullshit: what is 3 to the power of 18' }
    assert_response :success
    assert_equal '387420489', @response.body
  end

  test "should multiply plus" do
    get "/", params: { q: 'bullshit: what is 14 multiplied by 16 plus 14' }
    assert_response :success
    assert_equal '238', @response.body
  end
end
