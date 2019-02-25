defmodule PingPong.Match do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias PingPong.Match
  alias PingPong.UserMatch
  alias PingPong.Repo

  schema "matches" do
    field :match_date, :naive_datetime
    has_many :users_matches, UserMatch
    has_many :users, through: [:users_matches, :user]
    timestamps()
  end

  def list_matches() do
    Repo.all(Match)
  end

  def list_matches_for_user(user_id) do
    Repo.all(
      from m in Match,
        join: um in assoc(m, :users_matches),
        join: u in assoc(um, :user),
        where: um.user_id == ^user_id,
        preload: [users_matches: :user]
    )
    |> Enum.map(fn match ->
      %{
        date: match.match_date,
        home_user:
          extract_user_details(Enum.find(match.users_matches, fn um -> um.user_id == user_id end)),
        away_user:
          extract_user_details(Enum.find(match.users_matches, fn um -> um.user_id != user_id end))
      }
    end)
  end

  defp extract_user_details(user_match) do
    %{
      score: user_match.score,
      name: user_match.user.name,
      user_id: user_match.user_id
    }
  end
end
