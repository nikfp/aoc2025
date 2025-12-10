defmodule Part2 do
  def solve(input) do
    # first, get a set of edge coordinates for the whole thing
    input =
      input
      |> Enum.map(&List.to_tuple(&1))

    edge_list =
      input
      |> Enum.chunk_every(2, 1, input)
      |> Enum.map(fn [left, right] ->
        get_edge_coords(left, right) |> MapSet.new()
      end)

    # then get the list from part 1, starting from the top
    indexed_input =
      Enum.with_index(input)

    pairs =
      for {left, i1} <- indexed_input,
          {right, i2} <- indexed_input,
          i1 < i2,
          do: {left, right}

    sorted_coords =
      Enum.map(pairs, fn {{lx, ly}, {rx, ry}} ->
        {(abs(lx - rx) + 1) * (abs(ly - ry) + 1), {{lx, ly}, {rx, ry}}}
      end)
      |> Enum.sort(:desc)

    # for each pair, get all 4 edges and check that every edge
    # doesn't cross out of bounds
    Enum.find(sorted_coords, fn {_, {left, right}} ->
      rect_fits_in_bounds?(left, right, edge_list)
    end)
  end

  defp rect_fits_in_bounds?({x1, y1}, {x2, y2}, edge_list) do
    # get all 4 edges of each test rectangle and a set of the edges of the main polygon. 
    [
      {{x1, y1}, {x2, y1}},
      {{x1, y1}, {x1, y2}},
      {{x2, y2}, {x1, y2}},
      {{x2, y2}, {x2, y1}}
    ]
    |> Enum.reduce_while(true, fn {left, right}, _acc ->
      edge_set =
        get_edge_coords(left, right)
        |> MapSet.new()

      edge_inner =
        MapSet.difference(edge_set, MapSet.new([left, right]))

      potential_crossed_edges =
        edge_list
        |> Enum.filter(fn edge ->
          MapSet.intersection(edge, edge_inner) |> MapSet.size() > 0
        end)

      Enum.all?(potential_crossed_edges, fn el ->
        MapSet.intersection(el, edge_set) |> MapSet.size() > 1
      end)
      |> case do
        true -> {:cont, true}
        false -> {:halt, false}
      end
    end)

    # then switch to testing individual polygon edges. 
    # If the test edge touches a polygon edge at exactly 1 point 
    # and that point is not an endpoint of the test edge, that's a crossing, 
    # which indicates the test edge runs outside the main polygon. 
    # We can assume all corners are inside the polygon to start, 
    # so if no edges test as crossing, the test rectangle is inside the polygon.
  end

  defp get_edge_coords({x1, y1}, {x2, y2}) do
    if x1 == x2 do
      get_range(y1, y2)
      |> Enum.map(&{x1, &1})
    else
      get_range(x1, x2)
      |> Enum.map(&{&1, y1})
    end
  end

  defp get_range(a, b) do
    min(a, b)..max(a, b)
  end
end
