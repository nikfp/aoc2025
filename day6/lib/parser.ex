defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Stream.map(fn el ->
      String.split(el, " ", trim: true)
    end)
    |> Enum.reverse()
  end
end
