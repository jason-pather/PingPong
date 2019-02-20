defmodule PingPong.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    timestamps()
  end

  alias PingPong.Repo
  alias PingPong.User

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

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
