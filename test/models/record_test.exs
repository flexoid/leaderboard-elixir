defmodule Leaderboard.RecordTest do
  use Leaderboard.ModelCase

  alias Leaderboard.Record

  @valid_attrs %{project_id: "123", event_id: "ev1"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Record.changeset(%Record{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Record.changeset(%Record{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "saving_changeset assigns UUID as user_id if it's not provided" do
    changeset = Record.saving_changeset(%Record{}, %{})

    assert changeset.changes[:user_id]
    assert {:ok, _} = Ecto.UUID.dump(changeset.changes[:user_id])
  end

  test "saving_changeset does not re-assign used_id if provided in params" do
    changeset = Record.saving_changeset(%Record{}, %{"user_id" => "custom_id"})
    assert changeset.changes[:user_id] == "custom_id"
  end
end
