defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, ",", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end
end
