defmodule PopulationSim do
  @moduledoc """
  Documentation for `PopulationSim`.
  """

  def proliferate(grid) do
    grid
    |> Enum.with_index()
    |> Enum.map(&proliferate_row(&1, grid))
  end

  def proliferate(_grid, ticks) when ticks <= 0, do: nil
  def proliferate(grid, 1), do: proliferate(grid)

  def proliferate(grid, ticks) do
    1..ticks
    |> Enum.reduce(grid, fn _i, grid -> proliferate(grid) end)
  end

  def proliferate_row({row, y_pos}, grid) do
    row
    |> Enum.with_index()
    |> Enum.map(fn {cell_value, x_pos} ->
      cell_value_after_proliferation(cell_value, {x_pos, y_pos}, grid)
    end)
  end

  def cell_value_after_proliferation(cell_value, cell, grid) do
    case {cell_value, live_neighbours(cell, grid)} do
      {1, surrounding_population} when surrounding_population < 2 -> 0
      {1, surrounding_population} when surrounding_population > 3 -> 0
      {0, surrounding_population} when surrounding_population != 3 -> 0
      _ -> 1
    end
  end

  def live_neighbours(cell, grid) do
    neighbouring_indices(cell)
    |> neighbouring_cells(grid)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
    |> sub_value_from_cell(cell, grid)
  end

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
