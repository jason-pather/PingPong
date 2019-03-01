defmodule PingPongWeb.MatchController do
  use PingPongWeb, :controller

  alias PingPong.{Match, User, UserMatch}

  def index(conn, _params) do
    matches = Match.list_matches()
    render(conn, "matches.html", matches: matches)
  end

  def new(conn, _params) do
    changeset =
      Match.changeset(
        %Match{
          users_matches: [%UserMatch{user: %User{}}, %UserMatch{user: %User{}}]
          # users_matches: [%UserMatch{user: %User{}}]
        },
        %{}
      )

    users = User.list_users()
    # |> Enum.map(fn user -> [key: user.name, value: user.id] end)

    render(conn, "new.html",
      changeset: changeset,
      users: users
    )
  end

  def create(conn, %{"match" => match_params}) do
    # not sure you should have to modify the changeset like this,
    # there should be a better way to do this within the framework
    # Maybe there is a way to structure the changeset so that it
    # comes back in the format that is required.

    # figure out why there are duplicates on the UI!!

    IO.inspect(match_params)

    params = %{
      match_date: date_to_datetime(match_params["match_date"]),
      users_matches: Enum.map(match_params["users_matches"], fn {_k, v} -> v end)
    }

    case Match.create_match(params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created!")
        |> redirect(to: Routes.match_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        users = User.list_users()
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  defp date_to_datetime(date) do
    iso8601 = "#{date}T00:00:00Z"
    IO.inspect(iso8601)
    NaiveDateTime.from_iso8601!(iso8601)
  end
end
