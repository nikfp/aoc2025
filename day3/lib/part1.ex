defmodule Part1 do
  def solve(input) do
    # input arrives as a map
    # %{lines: [ [1, 2, 3, ...], [1, 2, 3, ...] ], line_length: integer}
    %{lines: lines} = input

    lines
    |> Enum.map(&process_line(&1))
    |> Enum.sum()
  end

  defp process_line(line) do
    line =
      line
      |> Enum.reverse()
      |> Enum.with_index()

    {high_digit, high_index} =
      line
      |> Enum.drop(1)
      |> Enum.max(fn {lv, li}, {rv, ri} ->
        lv > rv or (lv == rv and li > ri)
      end)

    {low_digit, _} =
      line
      |> Enum.take(high_index)
      |> Enum.max(fn {lv, li}, {rv, ri} ->
        lv > rv or (lv == rv and li > ri)
      end)

    [high_digit, low_digit]
    |> Integer.undigits()
  end
end
