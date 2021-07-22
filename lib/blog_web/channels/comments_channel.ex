defmodule BlogWeb.CommentsChannel do
  use BlogWeb, :channel

  def join(name, _payload, socket) do
    {:ok, %{nome: "Deu certo!!"}, socket}
  end

  def handle_in() do

  end

end
