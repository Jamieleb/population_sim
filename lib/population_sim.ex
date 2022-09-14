defmodule PopulationSim do
  @moduledoc """
  Documentation for `PopulationSim`.
  """

  def neighbouring_indices({x_position, y_position}) do
    x_range = range_within_boundary(x_position)
    y_range = range_within_boundary(y_position)
    {x_range, y_range}
  end

  def range_within_boundary(0), do: 0..1
  def range_within_boundary(8), do: 7..8
  def range_within_boundary(position), do: (position - 1)..(position + 1)

  def neighbouring_cells({x_range, y_range}, grid) do
    Enum.to_list(y_range)
    |> Enum.map(&Enum.at(grid, &1))
    |> Enum.map(&Enum.slice(&1, x_range))
  end

  def value_at_coordinates({x_pos, y_pos}, grid) do
    grid |> Enum.at(y_pos) |> Enum.at(x_pos)
  end

  def sub_value_from_cell(total, cell, grid) do
    total - value_at_coordinates(cell, grid)
  end
end
