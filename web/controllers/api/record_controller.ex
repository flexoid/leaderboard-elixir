defmodule Leaderboard.Api.RecordController do
  use Leaderboard.Web, :controller

  alias Leaderboard.RecordRepo
  alias Leaderboard.Record

  def update(conn, params) do
    changeset = Record.changeset(%Record{}, params)

    case RecordRepo.save(changeset) do
      {:ok, _} ->
        json(conn, changeset.changes)
      {:error, _} ->
        conn
        |> put_status(400)
        |> json(%{})
    end
  end
end
