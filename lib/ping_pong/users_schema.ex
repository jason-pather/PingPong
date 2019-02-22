defmodule PingPong.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias PingPong.{Repo, User, UserMatch, Match}

  schema "users" do
    field :name, :string
    has_many :users_matches, UserMatch
    has_many :matches, through: [:users_matches, :match]
    timestamps()
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def list_users() do
    Repo.all(User)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 30)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
