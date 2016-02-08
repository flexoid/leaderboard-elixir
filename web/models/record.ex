defmodule Leaderboard.Record do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "record" do
    field :user_id
    field :value
    field :name
    field :public_id
    field :level, :integer
    field :private_data
    field :public_data
  end

  @required_fields ~w()
  @optional_fields ~w(user_id value name public_id level private_data public_data)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
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
