defmodule Leaderboard.RecordRepo do

  def save(%Ecto.Changeset{model: %Leaderboard.Record{}} = changeset) do
    if changeset.valid? do
      user_id = changeset.changes[:user_id]
      args = Enum.reduce changeset.changes, [], fn({k, v}, acc) ->
        acc ++ [k, v]
      end

      Redix.command(redix_conn, ["HMSET", hash_key("proj1", "proj2", user_id)] ++ args)
    else
      {:error, {:invalid_changeset, changeset.errors}}
    end
  end

  defp hash_key(project_id, event_id, record_id) do
    "projects:#{project_id}:events:#{event_id}:scores:#{record_id}"
  end

  defp redix_conn do
    # FIXME: Rewrite this
    :erlang.whereis(:redix)
  end
end
