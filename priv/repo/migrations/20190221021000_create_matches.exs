defmodule PingPong.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :match_date, :naive_datetime, null: false
      timestamps()
    end
  end
end
