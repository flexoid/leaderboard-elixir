defmodule Leaderboard.ModelCase do
  @moduledoc """
  This module defines the test case to be used by
  model tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset

      import Leaderboard.ModelCase
    end
  end
end
