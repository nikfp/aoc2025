defmodule Part1 do
  def solve(input, iteration_count) do
    input_with_index =
      input |> Enum.with_index()

    pairs =
      for {left, first_index} <- input_with_index,
          {right, second_index} <- input_with_index,
          first_index < second_index,
          do: {left, right}

    counted_pairs =
      pairs
      |> Stream.map(fn {{x1, y1, z1} = left, {x2, y2, z2} = right} ->
        xd = abs(x1 - x2) * abs(x1 - x2)
        yd = abs(y1 - y2) * abs(y1 - y2)
        zd = abs(z1 - z2) * abs(z1 - z2)
        {xd + yd + zd, left, right}
      end)
      |> Enum.sort(:asc)
      |> Enum.take(iteration_count)

    connections_map =
      Enum.reduce(counted_pairs, %{}, fn {_, left, right}, map ->
        map
        |> Map.update(left, [right], fn existing -> [right | existing] end)
        |> Map.update(right, [left], fn existing -> [left | existing] end)
      end)

    get_first_graph(connections_map, [])
    |> Stream.map(&MapSet.size(&1))
    |> Enum.sort(:desc)
    |> Stream.take(3)
    |> Enum.product()
  end

  defp get_first_graph(map, sets) when map_size(map) == 0 do
    sets
  end

  defp get_first_graph(map, sets) do
    first_junction =
      Map.keys(map)
      |> List.first()

    {trimmed_map, set} = traverse(map, [first_junction], MapSet.new())

    get_first_graph(trimmed_map, [set | sets])
  end

  defp traverse(map, [], result_set) do
    {map, result_set}
  end

  defp traverse(map, [first_location | rest_locations], result_set) do
    if MapSet.member?(result_set, first_location) do
      traverse(map, rest_locations, result_set)
    else
      new_set = MapSet.put(result_set, first_location)
      {new_locations, updated_map} = Map.pop!(map, first_location)
      traverse(updated_map, new_locations ++ rest_locations, new_set)
    end
  end
end
