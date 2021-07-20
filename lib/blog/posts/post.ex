defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :description, :string

    timestamps()
  end

  @doc """
    - Changeset recebe uma estrutura de post, onde o CAST recebe uma estrutura e seus parametros
    pegando os parametros e inserindo na estrutura de Post
    - validate_requipere -> Verifica se o post tem todos os parametros
    - Quando se utiliza %Post{}, estamos dizendo que estamos passando uma 'Estrutura de Posta'
  """
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description], message: "Campo Obrigatório")
  end
end
