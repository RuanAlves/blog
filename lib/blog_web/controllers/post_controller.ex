defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.{Posts, Posts.Post}

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def delete(conn, %{"id" => id}) do
    Posts.delete_post(id)

    conn
    |> put_flash(:info, "Post foi deletado")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    changeset = Post.changeset(post)

    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def create(conn, %{"post" => post}) do
    case Posts.create_post(post) do
      {:ok, post} ->
        conn
        # Emite informação de Sucesso
        |> put_flash(:info, "Post criado com sucesso!")
        # Manipulando URL, para mostrar o POST cadastrado
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post_orig = Posts.get_post!(id)

    case Posts.update_post(post_orig, post_params) do
      {:ok, post_changeset} ->
        conn
        |> put_flash(:info, "Post atualizado com sucesso!")
        |> redirect(to: Routes.post_path(conn, :show, post_changeset))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, post: post_orig)
    end
  end

  @doc """
  resp_headers
    - Imprima o 3 elemento da lista
    - Imprima o 5 elemento da lista e o segundo elemento da Tupla​
  """
  # coveralls-ignore-start
  # def _new_exercicios(conn, _params) do
  #   # Jeito que fiz
  #   terceiro_elemento_lista = Enum.at(conn.req_headers, 3)
  #   quinto_elemento = Enum.at(conn.req_headers, 5)

  #   IO.inspect(terceiro_elemento_lista)
  #   IO.inspect(quinto_elemento)
  #   IO.inspect(elem(quinto_elemento, 1))

  #   # Jeito mais enxuto
  #   {element, list} = List.pop_at(conn.req_headers, 5)
  #   {first, second} = element
  #   IO.inspect(second)

  #   render(conn, "new.html")
  # end

  # coveralls-ignore-stop
end
