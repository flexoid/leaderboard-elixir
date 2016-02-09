defmodule Leaderboard.RecordRepo do
  alias Leaderboard.Record

  def save(%Ecto.Changeset{model: %Record{}} = changeset) do
    if changeset.valid? do
      save_record_attrs(changeset)
    else
      {:error, {:invalid_changeset, changeset.errors}}
    end
  end

  def get(project_id, event_id, record_id) do
    case Redix.command(redix_conn, ["HGETALL", hash_key(project_id, event_id, record_id)]) do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, values} when is_list(values) ->
        values = values
        |> Enum.chunk(2)
        |> Enum.reduce(%{}, fn([k, v], acc) -> Map.put(acc, k, v) end)

        record = %Record{}
        |> Record.changeset(values)
        |> Ecto.Changeset.apply_changes
        {:ok, record}

      {:error, e} ->
        {:error, e}
    end
  end

  defp hash_key(project_id, event_id, record_id) do
    "projects:#{project_id}:events:#{event_id}:scores:#{record_id}"
  end

  defp redix_conn do
    # FIXME: Rewrite this
    :erlang.whereis(:redix)
  end

  defp save_record_attrs(changeset) do
    user_id    = changeset.changes[:user_id]
    project_id = changeset.changes[:project_id]
    event_id   = changeset.changes[:event_id]

    args = Enum.reduce changeset.changes, [], fn({k, v}, acc) ->
      acc ++ [k, v]
    end

    Redix.command(redix_conn, ["HMSET",
      hash_key(project_id, event_id, user_id)] ++ args)
  end
end
