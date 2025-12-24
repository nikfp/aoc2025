defmodule Part2 do
  def solve(input) do
    # get x and y coords, sorted, then deduped, then compacted
    x_coords_index_map = get_x_coords_map(input)
    y_coords_index_map = get_y_coords_map(input)

    # get input, descending by size, with coords
    rectangle_sizes =
      input
      |> get_sizes()
      |> Enum.map(fn {[lx, ly], [rx, ry], size} ->
        {
          {
            Map.get(x_coords_index_map, lx),
            Map.get(y_coords_index_map, ly)
          },
          {
            Map.get(x_coords_index_map, rx),
            Map.get(y_coords_index_map, ry)
          },
          size
        }
      end)

    compacted_segment_coords =
      input
      |> Stream.chunk_every(2, 1, input)
      |> Enum.map(fn [[lx, ly], [rx, ry]] ->
        {
          {
            Map.get(x_coords_index_map, lx),
            Map.get(y_coords_index_map, ly)
          },
          {
            Map.get(x_coords_index_map, rx),
            Map.get(y_coords_index_map, ry)
          }
        }
      end)

    perimeter_set =
      compacted_segment_coords
      |> Enum.reduce(MapSet.new(), fn {left, right}, set ->
        get_edge_coords(left, right)
        |> MapSet.new()
        |> MapSet.union(set)
      end)
  end

  defp get_x_coords_map(input) do
    input
    |> Stream.map(fn [x, _] -> x end)
    |> Enum.uniq()
    |> Enum.sort()
    |> Stream.with_index()
    |> Enum.reduce(%{}, fn {coord, index}, acc ->
      Map.put(acc, coord, index)
    end)
  end

  defp get_y_coords_map(input) do
    input
    |> Stream.map(fn [_, y] -> y end)
    |> Enum.uniq()
    |> Enum.sort()
    |> Stream.with_index()
    |> Enum.reduce(%{}, fn {coord, index}, acc ->
      Map.put(acc, coord, index)
    end)
  end

  defp get_sizes(input) do
    indexed_input =
      Enum.with_index(input)

    pairs =
      for {left, i1} <- indexed_input,
          {right, i2} <- indexed_input,
          i1 < i2,
          do: {left, right}

    Enum.map(pairs, fn {[lx, ly] = first, [rx, ry] = second} ->
      {first, second, (abs(lx - rx) + 1) * (abs(ly - ry) + 1)}
    end)
    |> Enum.sort_by(fn {_, _, num} -> num end, :desc)
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
