defmodule PingPongWeb.HomeController do
  use PingPongWeb, :controller

  @fact_url "http://randomuselessfact.appspot.com/random.json?language=en"

  def load(conn, _params) do
    fact_string = get_fact()
    render(conn, "home.html", fact_string: fact_string)
  end

  def get_fact() do
    case HTTPoison.get(@fact_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> IO.inspect
        |> Poison.decode!()
        |> Map.get("text")

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "404 - fun fact not found :("

      {:error, %HTTPoison.Error{reason: reason}} ->
        "Fun fact not available :( #{reason}"
    end
  end
end
