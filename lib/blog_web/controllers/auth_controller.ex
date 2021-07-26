defmodule BlogWeb.AuthController do
  use BlogWeb, :controller
  alias Blog.Accounts

  # Para usar o 'requeste`, apenas chamar esse plug
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user = %{
      token: auth.credentials.token,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      image: auth.info.image,
      provider: provider
    }

    case Accounts.create_user(user) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Bem vindo!!! #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Erro ao autenticar usuário")
        |> redirect(to: Routes.page_path(conn, :index))
    end

    render(conn, "index.html")
  end
end
