defmodule PingPong.Matches do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :winning_score, :integer
    field :losing_score, :integer
    field :winning_user_id, :integer
    field :losing_user_id, :integer
    timestamps()
  end
end
