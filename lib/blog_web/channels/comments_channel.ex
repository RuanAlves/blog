defmodule BlogWeb.CommentsChannel do
  use BlogWeb, :channel
  alias Blog.{Posts, Comments}

  def join("comments:"<> post_id, _payload, socket) do
    post = Posts.get_post_with_comments!(post_id)
    {:ok, %{comments: post.comments}, assign(socket, :post_id, post.id)}
  end

  @doc """
    name -> Receberá o nome do evento, no caso "comment:add"
    content ou attrs -> Receberá os dados que o usuário informou, no caso o comentário (%{"content" => "AQUI O COMENTÁRIO"})
  """
  def handle_in("comment:add", content, socket) do
    response =
      socket.assigns.post_id
    |> Comments.create_comment(content)

    case response do
      {:ok, _comment} ->
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{erros: changeset}}}
    end
  end

end
