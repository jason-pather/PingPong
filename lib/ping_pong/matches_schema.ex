defmodule PingPong.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias PingPong.Match
  alias PingPong.UserMatch
  alias PingPong.Repo

  schema "matches" do
    field :match_date, :naive_datetime
    has_many :users_matches, UserMatch
    timestamps()
  end

  def list_matches() do
    Repo.all(Match)
  end
end
