defmodule Leaderboard.Api.RecordView do
  use Leaderboard.Web, :view

  def render("record.json", %{record: record}) do
    %{
      user_id: record.user_id,
      value: record.value,
      name: record.name,
      public_id: record.public_id,
      level: record.level,
      private_data: record.private_data,
      public_data: record.private_data
    }
  end
end
