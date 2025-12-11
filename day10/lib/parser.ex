defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      split_string = String.split(line, ~r/[\[\]\(\)\{\} ]/, trim: true)

      lights =
        List.first(split_string)
        |> String.split("", trim: true)
        |> Enum.map(fn
          "." -> 0
          "#" -> 1
        end)

      joltages =
        List.last(split_string)
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer(&1))

      switches =
        Enum.drop(split_string, 1)
        |> Enum.drop(-1)
        |> Enum.map(fn el ->
          String.split(el, ",", trim: true)
          |> Enum.map(&String.to_integer(&1))
        end)

      %{
        lights: lights,
        joltages: joltages,
        switches: switches
      }
    end)
  end
end
