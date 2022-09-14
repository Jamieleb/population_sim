defmodule PopulationSimTest do
  use ExUnit.Case
  doctest PopulationSim

  @initial_grid [
    [0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

  @state_after_one_tick [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

  @state_after_ten_ticks [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 1, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

  describe "range_within_boundary function" do
    test "for central cell" do
      assert PopulationSim.range_within_boundary(4) == 3..5
    end

    test "for cell at first row or column" do
      assert PopulationSim.range_within_boundary(0) == 0..1
    end

    test "for cell at final row or column" do
      assert PopulationSim.range_within_boundary(8) == 7..8
    end
  end

  describe "value at coordinates function" do
    test "central cell" do
      assert PopulationSim.value_at_coordinates({3, 2}, @initial_grid) == 1
    end

    test "first row cell" do
      assert PopulationSim.value_at_coordinates({3, 0}, @initial_grid) == 0
    end

    test "last column cell" do
      assert PopulationSim.value_at_coordinates({8, 4}, @initial_grid) == 0
    end
  end

  describe "neighbouring_cells" do
    test "neighbouring cells function for central cell" do
      assert PopulationSim.neighbouring_cells({3..5, 2..4}, @initial_grid) == [
               [1, 0, 0],
               [0, 0, 0],
               [0, 0, 0]
             ]
    end

    test "neighbouring cells function for edge cell" do
      assert PopulationSim.neighbouring_cells({0..1, 0..1}, @initial_grid) == [
               [0, 0],
               [0, 0]
             ]
    end
  end
  describe "value_at_coordinates function" do
    test "cell in centre" do
      assert PopulationSim.value_at_coordinates({3, 2}, @initial_grid) == 1
    end

    test "cell at edge" do
      assert PopulationSim.value_at_coordinates({0, 1}, @initial_grid) == 0
    end
  end
end
