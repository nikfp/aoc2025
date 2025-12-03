defmodule Part2 do
  def solve(input) do
    # input arrives as a map
    # %{lines: [ [1, 2, 3, ...], [1, 2, 3, ...] ], line_length: integer}
    %{lines: lines, line_length: line_length} = input

    lines
    |> Enum.map(&process_line(&1, 12, line_length))
    |> Enum.sum()
  end

  defp process_line(line, count, line_length) do
    line =
      line
      |> Enum.reverse()
      |> Enum.with_index()

    {list, _} =
      1..count
      |> Enum.reverse()
      |> Enum.reduce({[], line_length}, fn el, {result_list, high_index} ->
        {_, next_index} =
          el =
          line
          |> Enum.drop(el - 1)
          |> Enum.take(high_index - el + 1)
          |> Enum.sort(fn {d1, i1}, {d2, i2} ->
            d1 > d2 or (d1 == d2 and i1 > i2)
          end)
          |> List.first()

        {[el | result_list], next_index}
      end)

    list
    |> Enum.map(fn {d, _} -> d end)
    |> Enum.reverse()
    |> Enum.join()
    |> String.to_integer()
  end
end
