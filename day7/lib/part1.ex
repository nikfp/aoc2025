defmodule Part1 do
  def solve(input) do
    [first_line | remaining_lines] = input

    starting_index =
      String.split(first_line, "", trim: true)
      |> Enum.find_index(&(&1 == "S"))

    Enum.reduce(remaining_lines, {MapSet.new() |> MapSet.put(starting_index), 0}, fn line, acc ->
      line
      |> String.split("", trim: true)
      |> Stream.with_index()
      |> Enum.reduce(acc, fn
        {"^", index}, {map, count} ->
          if MapSet.member?(map, index) do
            updated_map =
              map
              |> MapSet.delete(index)
              |> MapSet.put(index + 1)
              |> MapSet.put(index - 1)

            {updated_map, count + 1}
          else
            {map, count}
          end

        {_, _}, a ->
          a
      end)
    end)
    |> elem(1)
  end
end
