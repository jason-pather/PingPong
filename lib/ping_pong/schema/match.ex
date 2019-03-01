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

  # A Match from the UI will actually consist of
  #  user1, user2, user1score, user2score, date
  # The only thing that we need to store here is the date!
  # Need to create UserMatches to store the other information
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:match_date])
    |> cast_assoc(:users_matches, required: true)
    |> validate_required([:match_date])
  end

  def list() do
    Repo.all(
      from m in Match,
        join: um in assoc(m, :users_matches),
        join: u in assoc(um, :user),
        preload: [users_matches: :user]
    )
  end

  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> IO.inspect()
    |> Repo.insert()
  end

  def list_matches() do
    Repo.all(
      from m in Match,
        join: um in assoc(m, :users_matches),
        join: u in assoc(um, :user),
        preload: [users_matches: :user],
        group_by: m.id
    )
    |> Enum.map(fn match ->
      %{
        date: match.match_date,
        home_user: extract_user_details(match, 0),
        away_user: extract_user_details(match, 1)
      }
    end)
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
          extract_user_details(match, Enum.find_index(match, fn um -> um.user_id == user_id end)),
        away_user:
          extract_user_details(match, Enum.find_index(match, fn um -> um.user_id != user_id end))
      }
    end)
  end

  defp extract_user_details(match, index) do
    um = Enum.fetch!(match.users_matches, index)

    %{
      score: um.score,
      name: um.user.name,
      user_id: um.user_id
    }
  end
end
