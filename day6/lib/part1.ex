defmodule Part1 do
  def solve(input) do
    input
    |> Enum.reverse()
    |> Enum.zip_reduce(0, fn [operator | numbers], acc ->
      case operator do
        "+" ->
          (Stream.map(numbers, &String.to_integer/1) |> Enum.sum()) + acc

        "*" ->
          (Stream.map(numbers, &String.to_integer/1) |> Enum.product()) + acc
      end
    end)
  end
end
