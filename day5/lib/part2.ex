defmodule Part2 do
  def solve(input) do
    # input arrives as %{
    #   ranges: [ {Int, Int}, ... ],
    #   ingredients_list: [Int, ... ]
    # }
    %{ranges: ranges} = input

    ranges
    |> Enum.sort()
    |> narrow_ranges({0, 0}, [])
    |> Enum.map(fn {low, high} -> high - low + 1 end)
    |> Enum.sum()
  end

  defp narrow_ranges([], {_, _}, results) do
    results
  end

  defp narrow_ranges([{cur_low, cur_high} | rest], {prev_low, prev_high}, results) do
    # Note ranges arrives sorted by low end value, ascending

    # if the current low is greater than the prev high, 
    # push current values to the results, and send as new low and high
    if cur_low > prev_high do
      narrow_ranges(rest, {cur_low, cur_high}, [{cur_low, cur_high} | results])
    else
      # if the current high is greater than the previous high, define new range for 
      # results and previous values on next recursion
      # new values is a sub-range starting one above previous high
      if cur_high > prev_high do
        narrow_ranges(rest, {prev_high + 1, cur_high}, [{prev_high + 1, cur_high} | results])
      else
        # fallthrough case, current range is fully within previous range. 
        # send previous values and don't track a new result. 
        narrow_ranges(rest, {prev_low, prev_high}, results)
      end
    end
  end
end
