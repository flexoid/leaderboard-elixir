defmodule Leaderboard.Record do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "record" do
    field :project_id
    field :event_id

    field :user_id
    field :name
    field :public_id
    field :value, :integer
    field :level, :integer
    field :private_data
    field :public_data
  end

  @required_fields ~w(project_id event_id)
  @optional_fields ~w(user_id value name public_id level private_data public_data)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def saving_changeset(model, params \\ :empty) do
    changeset(model, params)
    |> assign_user_id()
  end

  defp assign_user_id(changeset) do
    if changeset.changes[:user_id] do
      changeset
    else
      put_change(changeset, :user_id, Ecto.UUID.generate())
    end
  end
end
