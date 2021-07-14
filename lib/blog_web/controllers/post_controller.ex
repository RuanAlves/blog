defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Posts.Post

  def index(conn, _params) do
    posts = Blog.Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  resp_headers
    - Imprima o 3 elemento da lista
    - Imprima o 5 elemento da lista e o segundo elemento da Tupla​
  """
  def _new_exercicios(conn, _params) do
    # Jeito que fiz
    terceiro_elemento_lista = Enum.at(conn.req_headers, 3)
    quinto_elemento = Enum.at(conn.req_headers, 5)

    IO.inspect(terceiro_elemento_lista)
    IO.inspect(quinto_elemento)
    IO.inspect(elem(quinto_elemento, 1))

    # Jeito mais enxuto
    {element, list} = List.pop_at(conn.req_headers, 5)
    {first, second} = element
    IO.inspect(second)

    render(conn, "new.html")
  end
end
