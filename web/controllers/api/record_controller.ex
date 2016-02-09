defmodule Leaderboard.Api.RecordController do
  use Leaderboard.Web, :controller

  alias Leaderboard.RecordRepo
  alias Leaderboard.Record

  def show(conn, params) do

    case RecordRepo.get(params["project_id"], params["event_id"], params["user_id"]) do
      {:ok, record} ->
        json(conn, Phoenix.View.render_one(record, Leaderboard.Api.RecordView,
          "record.json", %{record: record}))
      {:error, :not_found} ->
        conn
        |> put_status(404)
        |> json(%{})
    end

  end

  def update(conn, params) do
    changeset = Record.saving_changeset(%Record{}, params)

    case RecordRepo.save(changeset) do
      {:ok, _} ->
        json(conn, %{private_user_id: changeset.changes[:user_id]})
      {:error, _} ->
        conn
        |> put_status(400)
        |> json(%{})
    end
  end
end
