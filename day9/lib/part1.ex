defmodule Part1 do
  def solve(input) do
    indexed_input =
      Enum.with_index(input)

    pairs =
      for {left, i1} <- indexed_input,
          {right, i2} <- indexed_input,
          i1 < i2,
          do: {left, right}

    Enum.map(pairs, fn {[lx, ly], [rx, ry]} ->
      (abs(lx - rx) + 1) * (abs(ly - ry) + 1)
    end)
    |> Enum.sort(:desc)
    |> List.first()
  end
end
