defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.replace("\n", "")
    |> String.split(",", trim: true)
    |> Enum.map(fn el ->
      String.split(el, "-", trim: true)
    end)
    |> Enum.map(fn [begin, ending] ->
      [String.to_integer(begin), String.to_integer(ending)]
    end)
  end
end
