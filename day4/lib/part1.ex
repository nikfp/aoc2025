defmodule Part1 do
  def solve(input) do
      input
      |> Map.keys()
      |> Enum.filter(&less_than_4_adjacent?(&1, input))
      |> Enum.count()
  end

  @offsets [-1, 0, 1]

  defp less_than_4_adjacent?({x, y}, map) do
    Enum.reduce_while(@offsets, 0, fn x_offset, outer_count ->
      Enum.reduce_while(@offsets, outer_count, fn y_offset, inner_count ->
        if x_offset == 0 and y_offset == 0 do
          {:cont, inner_count} 
        else
          Map.get(map, {x + x_offset, y + y_offset}, false)
          |> case do
            true -> inner_count + 1
            false -> inner_count
          end
          |> case do
            val when val >= 4 -> {:halt, false}
            val -> {:cont, val}
          end
        end
      end)
      |> case do
        val when val >= 4 -> {:halt, false}
        val -> {:cont, val}
      end
    end)
  end
end
