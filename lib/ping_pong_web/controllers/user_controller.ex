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
end
