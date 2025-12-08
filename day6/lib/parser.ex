defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
