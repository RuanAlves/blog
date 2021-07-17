defmodule Blog.PostsTest do
  use Blog.DataCase
  alias Blog.{Posts, Posts.Post}

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  @update_post %{
    title: "updated",
    description: "updated"
  }

  def post_fixture(_attrs \\ %{}) do
    {:ok, post} = Posts.create_post(@valid_post)
    post
  end

  test "list_posts/0 retorna todos os posts" do
    post = post_fixture()
    assert Posts.list_posts() == [post]
  end

  test "get_post/1 retorna apenas o post criado" do
    post = post_fixture()
    assert Posts.get_post!(post.id) == post
  end

  test "create_post/1 with valid data" do
    assert {:ok, %Post{} = post_create} = Posts.create_post(@valid_post)
    assert post_create.title == "Phoenix Framework"
    assert post_create.description == "Lorem"
  end

  test "update_post/2 with valid data" do
    post = post_fixture()
    assert {:ok, %Post{} = post} = Posts.update_post(post.id, @update_post)
    assert post.title == "updated"
    assert post.description == "updated"
  end

  test "delete/1" do
    post = post_fixture()
    assert post = Posts.delete_post(post.id)
    # Espera não encontraro Post deletado
    assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
  end
end
