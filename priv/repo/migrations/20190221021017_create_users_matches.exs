defmodule PingPong.Repo.Migrations.CreateUsersMatches do
  use Ecto.Migration

  def change do
    create table(:users_matches) do
      add :score, :integer, null: false
      add :match_id, :integer, null: false
      add :user_id, :integer, null: false
      timestamps()
    end

    create unique_index(:users_matches, [:id])
  end
end
