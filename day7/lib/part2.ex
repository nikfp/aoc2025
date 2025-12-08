defmodule Part2 do
  def solve(input) do
    [first_line | remaining_lines] = input

    starting_index =
      String.split(first_line, "", trim: true)
      |> Enum.find_index(&(&1 == "S"))

    map_width =
      String.split(first_line, "", trim: true)
      |> length()

    starting_map =
      1..map_width
      |> Enum.reduce(%{}, fn el, acc -> Map.put(acc, el - 1, 0) end)
      |> Map.put(starting_index, 1)

    Enum.reduce(remaining_lines, starting_map, fn line, acc ->
      line
      |> String.split("", trim: true)
      |> Stream.with_index()
      |> Enum.reduce(acc, fn {char, index}, map ->
        case char do
          "^" ->
            case Map.fetch!(map, index) do
              val when val > 0 ->
                map
                |> Map.put(index, 0)
                |> Map.update!(index - 1, fn prev -> prev + val end)
                |> Map.update!(index + 1, fn prev -> prev + val end)

              _val ->
                map
            end

          _ ->
            map
        end
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
