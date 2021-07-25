defmodule BlogWeb.CommentsChannelTest do
  use BlogWeb.ChannelCase
  alias Blog.Posts
  alias BlogWeb.UserSocket

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  setup do
    {:ok, post} = Posts.create_post(@valid_post)
    {:ok, socket} = connect(UserSocket, %{})

    {:ok, socket: socket, post: post}
  end

  @doc """
    - Para ver mais sobre como testar comunitários, leia a documentação:
    https://hexdocs.pm/phoenix/testing_channels.html
    https://hexdocs.pm/phoenix/Phoenix.ChannelTest.html
    - Para saber de onde foi tirados como fazer os testes com, olhar MODULE: Phoenix.ChannelTest
    - subscribe_and_join é uma função que irá retornar um objeto Channel, que é o canal que irá receber as mensagens, irá acessar o sockect.js
  """
  test "deve se conectar ao socket", %{socket: socket, post: post} do
    {:ok, comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})
    assert post.id == socket.assigns.post_id
    assert [] == comentarios.comments
  end

  test "deve criar um comentario", %{socket: socket, post: post} do
    {:ok, _comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    ref = push(socket, "comment:add", %{"content" => "abcd"})

    assert_reply ref, :ok, %{}
    broadcast_event = "comments:#{post.id}:new"
    assert_broadcast broadcast_event, %{comment: %{content: "abcd"}}
  end
end
