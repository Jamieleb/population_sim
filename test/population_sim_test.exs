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

  describe "proliferate" do
    test "for one tick use function with arity of 1" do
      assert PopulationSim.proliferate(@initial_grid) == @state_after_one_tick
    end

    test "for 0 ticks, return nil" do
      assert PopulationSim.proliferate(@initial_grid, 0) == nil
    end

    test "for 1 tick and proliferate/2" do
      assert PopulationSim.proliferate(@initial_grid, 1) == @state_after_one_tick
    end

    test "for 10 ticks" do
      assert PopulationSim.proliferate(@initial_grid, 10) == @state_after_ten_ticks
    end
  end

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

  describe "live_neighbours" do
    test "calculate for central cell with 1 live neighbour" do
      assert PopulationSim.live_neighbours({4, 3}, @initial_grid) == 1
    end

    test "calculate for central cell with 2 live neighbours" do
      assert PopulationSim.live_neighbours({4, 2}, @initial_grid) == 2
    end

    test "calculate for edge cell with 0 live neighbours" do
      assert PopulationSim.live_neighbours({0, 0}, @initial_grid) == 0
    end

    test "calculate for edge cell with 1 live neighbours" do
      assert PopulationSim.live_neighbours({0, 1}, @initial_grid) == 1
    end

    test "calculate for edge cell with 2 live neighbours" do
      assert PopulationSim.live_neighbours({3, 0}, @initial_grid) == 2
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

  describe "cell value after proliferation" do
    test "live cell with fewer than two live neighbours" do
      assert PopulationSim.cell_value_after_proliferation(1, {2, 0}, @initial_grid) == 0
    end

    test "live cell with more than three live neighbours" do
      assert PopulationSim.cell_value_after_proliferation(1, {2, 1}, @initial_grid) == 0
    end

    test "live cell with two live neighbours" do
      assert PopulationSim.cell_value_after_proliferation(1, {2, 2}, @initial_grid) == 1
    end

    test "dead cell with two live neighbours" do
      assert PopulationSim.cell_value_after_proliferation(0, {3, 2}, @initial_grid) == 0
    end

    test "live cell with three live neighbours" do
      assert PopulationSim.cell_value_after_proliferation(0, {1, 1}, @initial_grid) == 1
    end
  end
end
