defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(& String.next_grapheme(&1))
    |> Enum.map(fn {dir, count} -> {dir, String.to_integer(count) } end)
  end
end
