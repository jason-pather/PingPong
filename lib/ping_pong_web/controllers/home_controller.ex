defmodule PingPongWeb.HomeController do
  use PingPongWeb, :controller

  alias PingPong.User

  @fact_url "http://randomuselessfact.appspot.com/random.json?language=en"

  def load(conn, _params) do
    users = User.list_users()

    fact_string = get_fact()

    # need to populate users here and then send to the template
    # in the template need to loop through all the users and generate some htm for each one
    render(conn, "home.html", users: users, fact_string: fact_string)
  end

  def get_fact() do
    case HTTPoison.get(@fact_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!()
        |> Map.get("text")

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "404 - fun fact not found :("

      {:error, %HTTPoison.Error{reason: reason}} ->
        "Fun fact not available :( #{reason}"
    end
  end
end
