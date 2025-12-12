defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [first, rest] = String.split(line, ":", trim: true)

      {
        first,
        rest |> String.split(" ", trim: true)
      }
    end)
  end
end
