defmodule PingPongWeb.UserController do
  use PingPongWeb, :controller

  alias PingPong.User

  def show(conn, %{"id" => id}) do
    user = PingPong.User.get_user(id)
    render(conn, "user.html", name: user.name)
  end

  def index(conn, _params) do
    users = User.list_users()

    render(conn, "users.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case User.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
