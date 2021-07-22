defmodule Blog.Posts do
  alias Blog.{Posts.Post, Repo}

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def get_post_with_comments!(id) do
    get_post!(id)
    |> Repo.preload(:comments)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    # Retorna um changeset, ou seja o post é um changeset com estrutura de um post
    |> Post.changeset(attrs)
    # Insere o map (changeset Post) no resositorio
    |> Repo.insert()
  end

  def update_post(post, post_params) do
    post
    |> Post.changeset(post_params)
    |> Repo.update()
  end

  def delete_post(id) do
    get_post!(id)
    |> Repo.delete!()
  end
end
