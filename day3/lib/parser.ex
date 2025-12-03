defmodule Parser do
  def parse(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true) |> Enum.map(&String.to_integer(&1))
      end)

    line_length = lines |> List.first() |> length()

    %{lines: lines, line_length: line_length}
  end
end
