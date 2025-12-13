defmodule Parser do
  def parse(file) do
    [boxes | shapes] =
      file
      |> File.read!()
      |> String.split("\n\n", trim: true)
      |> Enum.reverse()

    boxes =
      boxes
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [size, index_list] =
          line
          |> String.split(":", trim: true)

        size =
          String.split(size, "x", trim: true)
          |> Enum.map(&String.to_integer/1)
          |> Enum.product()

        index_list =
          index_list
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)
          |> Enum.with_index()

        %{size: size, index_list: index_list}
      end)

    shapes =
      shapes
      |> Enum.reduce(%{}, fn shape, acc ->
        [index, positions] = String.split(shape, ":", trim: true)

        index = String.to_integer(index)

        positions = String.count(positions, "#")

        Map.put(acc, index, positions)
      end)

    [shapes, boxes]
  end
end
