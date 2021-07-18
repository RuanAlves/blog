defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  @update_post %{
    title: "Data Updated",
    description: "Lorem"
  }

  @post_vazio %{
    title: nil,
    description: nil
  }

  test "listar todos os posts", %{conn: conn} do
    Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "pegar um post por id", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "entrar no formulario de criacao de post", %{conn: conn} do
    conn = get(conn, Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Novo Post"
  end

  test "entrar no formulario de alteracao de posts", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :edit, post))
    assert html_response(conn, 200) =~ "Editar Post"
  end

  test "criar um post", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "criar um post com valores invalidos", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create), post: %{})
    assert html_response(conn, 200) =~ "Campo Obrigatório"
  end

  test "alterar um post", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = put(conn, Routes.post_path(conn, :update, post), post: @update_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Data Updated"
  end

  test "alterar um post com valores invalidos", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = put(conn, Routes.post_path(conn, :update, post), post: @post_vazio)
    assert html_response(conn, 200) =~ "Editar Post"
  end

  test "delete", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = delete(conn, Routes.post_path(conn, :delete, post))
    assert redirected_to(conn) == Routes.post_path(conn, :index)

    assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
  end
end
