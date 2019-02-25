defmodule PingPong.UserMatch do
  use Ecto.Schema
  import Ecto.Changeset

  alias PingPong.{User, Match, UserMatch, Repo}

  # Find the winner of a match
  # SELECT MAX(score) FROM users_matches WHERE game_id = 123

  # Find all matches
  # SELECT UM.score, U.name, M.game_date FROM Matches M
  # JOIN Users_Matches UM ON UM.game_id = M.game_id
  # JOIN Users U ON U.user_id = UM.user_id
  # WHERE UM.user_id = 1

  # there is no model that holds all this data though

  # iex commands
  # iex(13)> Repo.insert(%Match{ match_date: ~N[2019-02-08 22:30:11]})

  schema "users_matches" do
    field :score, :integer
    belongs_to :user, User
    belongs_to :match, Match
    timestamps()
  end

  def get_user_match_with_user_name(match_id) do
    Repo.one()
  end
end
