defmodule Part1 do
  def solve(input) do
    # input arrives as %{
    #   ranges: [ {Int, Int}, ... ],
    #   ingredients_list: [Int, ... ]
    # }
    %{ranges: ranges, ingredients_list: ingredients_list} = input

    ingredients_list
    |> Stream.filter(& falls_within_fresh_ranges?(&1, ranges))
    |> Enum.count()
  end

  defp falls_within_fresh_ranges?(id, ranges) do
    Enum.any?(ranges, fn {low, high} -> low <= id and id <= high end)
  end
end
