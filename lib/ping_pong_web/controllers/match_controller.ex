defmodule PingPongWeb.MatchController do
  use PingPongWeb, :controller

  alias PingPong.Match

  def index(conn, _params) do
    matches = Match.list_matches()
    render(conn, "matches.html", matches)
  end
end
