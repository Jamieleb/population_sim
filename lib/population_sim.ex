defmodule PopulationSim do
  @moduledoc """
  Documentation for `PopulationSim`.
  """

  def neighbouring_cells({x_range, y_range}, grid) do
    Enum.to_list(y_range)
    |> Enum.map(&Enum.at(grid, &1))
    |> Enum.map(&Enum.slice(&1, x_range))
  end

  def value_at_coordinates({x_pos, y_pos}, grid) do
    grid |> Enum.at(y_pos) |> Enum.at(x_pos)
  end
end
