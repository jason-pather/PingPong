defmodule PingPongWeb.UserController do
  use PingPongWeb, :controller

  def show(conn, %{"id" => id}) do
    user = PingPong.User.get_user(id)
    render(conn, "user.html", name: user.name)
  end
end
