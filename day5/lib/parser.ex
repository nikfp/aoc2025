defmodule Parser do
  def parse(file) do
    [ranges_string, ingredients_string] =
      File.read!(file)
      |> String.split("\n\n", trim: true)

    ranges =
      String.split(ranges_string, "\n", trim: true)
      |> Enum.map(fn range ->
        [low, high] =
          String.split(range, "-", trim: true)
          |> Enum.map(&String.to_integer/1)

        {low, high}
      end)

    ingredients_list =
      ingredients_string
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    %{ranges: ranges, ingredients_list: ingredients_list}
  end
end
