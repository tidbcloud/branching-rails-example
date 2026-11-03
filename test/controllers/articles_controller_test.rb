require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @original_username = ENV["ARTICLE_ADMIN_USERNAME"]
    @original_password = ENV["ARTICLE_ADMIN_PASSWORD"]
    ENV["ARTICLE_ADMIN_USERNAME"] = "test-admin"
    ENV["ARTICLE_ADMIN_PASSWORD"] = "test-password"
    @article = articles(:one)
  end

  teardown do
    ENV["ARTICLE_ADMIN_USERNAME"] = @original_username
    ENV["ARTICLE_ADMIN_PASSWORD"] = @original_password
  end

  test "articles remain publicly readable" do
    ENV.delete("ARTICLE_ADMIN_USERNAME")
    ENV.delete("ARTICLE_ADMIN_PASSWORD")

    get root_path
    assert_response :success
    get articles_path
    assert_response :success
    get article_path(@article)
    assert_response :success
  end

  test "anonymous and incorrect credentials cannot access write actions" do
    [{}, authorization("wrong-user", "test-password"),
     authorization("test-admin", "wrong-password")].each do |headers|
      assert_write_actions_denied(headers)
    end
  end

  test "missing or blank administrator configuration denies writes" do
    ["ARTICLE_ADMIN_USERNAME", "ARTICLE_ADMIN_PASSWORD"].each do |key|
      [nil, ""].each do |value|
        previous_value = ENV[key]
        ENV[key] = value
        assert_write_actions_denied(authorization)
        assert_write_actions_denied(authorization("", ""))
        ENV[key] = previous_value
      end
    end
  end

  test "authentication happens before looking up a requested article" do
    get edit_article_path(id: "missing")
    assert_response :unauthorized
    patch article_path(id: "missing"), params: { article: { title: "Changed" } }
    assert_response :unauthorized
    delete article_path(id: "missing")
    assert_response :unauthorized
  end

  test "administrator can create edit update and delete articles" do
    headers = authorization
    get new_article_path, headers: headers
    assert_response :success

    assert_difference("Article.count", 1) do
      post articles_path, params: { article: { title: "New article", body: "A valid article body." } }, headers: headers
      assert_redirected_to root_path
    end

    get edit_article_path(@article), headers: headers
    assert_response :success

    patch article_path(@article), params: { article: { title: "Updated", body: "An updated article body." } }, headers: headers
    assert_redirected_to root_path
    assert_equal "Updated", @article.reload.title

    assert_difference("Article.count", -1) do
      delete article_path(@article), headers: headers
      assert_redirected_to root_path
    end
  end

  private

  def authorization(username = "test-admin", password = "test-password")
    { "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(username, password) }
  end

  def assert_write_actions_denied(headers)
    original_attributes = @article.attributes
    assert_no_difference("Article.count") do
      get new_article_path, headers: headers
      assert_response :unauthorized
      assert response.headers["WWW-Authenticate"].present?

      post articles_path, params: { article: { title: "Unauthorized", body: "An unauthorized article." } }, headers: headers
      assert_response :unauthorized
      get edit_article_path(@article), headers: headers
      assert_response :unauthorized
      patch article_path(@article), params: { article: { title: "Unauthorized" } }, headers: headers
      assert_response :unauthorized
      delete article_path(@article), headers: headers
      assert_response :unauthorized
    end
    assert_equal original_attributes, @article.reload.attributes
  end
end
