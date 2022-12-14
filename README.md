# PopulationSim

Live coding interview task. Completed under time pressure (90mins)

## Task
Create a function to model a simulated population growth/decline system.
The system is represented as a two-dimensional grid of square cells, each of which is in one of two possible states: alive or dead, "populated" or "unpopulated", 1 or 0. Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:
- Any live cell with less than two live neighbours dies, as if caused by underpopulation.
- Any live cell with two or three live neighbours survives to the next generation.
- Any live cell with more than three live neighbours dies, as if by overpopulation.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
An initial pattern constitutes the seed of the system. 

The first generation is created by applying the above rules simultaneously to every cell in the seed. Births and deaths occur simultaneously, and the moment at which this happens is called a tick (in other words, each generation is a pure function of the preceding one). The rules continue to be applied repeatedly to create further generations.

## Assumptions

- Assume that the board's grid of cells is fixed to a 9 x 9 layout.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `population_sim` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:population_sim, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/population_sim>.

