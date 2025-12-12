defmodule Part1 do
  alias Graph

  def solve(input) do
    graph =
      input
      |> Enum.reduce(Graph.new(), fn {start, ends}, graph ->
        Enum.reduce(ends, graph, fn out, g ->
          Graph.add_edge(g, start, out)
        end)
      end)

    Graph.get_paths(graph, "you", "out")
    |> Enum.count()
  end
end
