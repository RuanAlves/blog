defmodule Blog.Repo.Migrations.RelationPostsComments do
  use Ecto.Migration

  @doc """
    - Altera a tabela 'Comments', onde referencia a tabala 'Posts'com o atributo 'post_id',
      # :posts ->  Nome da tabela que vai ser referenciada
      # on_delete -> Acão que vai ocorrer ao relaizar um DELETE
  """
  def change do
    alter table(:comments) do
      add :post_id, references(:posts, on_delete: :delete_all)
    end
  end
end
