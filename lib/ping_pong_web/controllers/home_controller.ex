defmodule PingPongWeb.HomeController do
  use PingPongWeb, :controller

  def load(conn, _params) do
    # users =  need to populate users here and then send to the template
    # in the template need to loop through all the users and generate some htm for each one
    render(conn, "home.html")
  end
end
