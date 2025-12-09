defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.map(fn [x, y, z] -> {x, y, z} end)
  end
end
