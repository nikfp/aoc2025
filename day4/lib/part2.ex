defmodule Part2 do
  def solve(input) do
    # input arrives as %{{x_loc, y_loc} => true, ....}
    # representing map of only roll locations
    reduce_count_rolls_removed(input, 0)
  end

  defp reduce_count_rolls_removed(map, count) do
    removeable_locations =
      map
      |> Map.keys()
      |> Enum.filter(&less_than_4_adjacent?(&1, map))

    case Enum.count(removeable_locations) do
      0 ->
        count

      removeable_count ->
        Map.drop(map, removeable_locations) 
        |> reduce_count_rolls_removed(count + removeable_count)
    end
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
