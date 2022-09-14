defmodule PopulationSim do
  @moduledoc """
  Documentation for `PopulationSim`.
  """

  def value_at_coordinates({x_pos, y_pos}, grid) do
    grid |> Enum.at(y_pos) |> Enum.at(x_pos)
  end
end
