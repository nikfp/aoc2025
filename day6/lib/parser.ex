defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn el ->
      String.split(el, " ", trim: true)
    end)
  end
end
