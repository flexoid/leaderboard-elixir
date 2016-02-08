defmodule Leaderboard.RecordTest do
  use Leaderboard.ModelCase

  alias Leaderboard.Record

  test "changeset assigns UUID as user_id if it's not provided" do
    changeset = Record.changeset(%Record{}, %{})

    assert changeset.changes[:user_id]
    assert {:ok, _} = Ecto.UUID.dump(changeset.changes[:user_id])
  end

  test "changeset does not re-assign used_id if provided in params" do
    changeset = Record.changeset(%Record{}, %{"user_id" => "custom_id"})
    assert changeset.changes[:user_id] == "custom_id"
  end
end
