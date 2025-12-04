defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, row_index}, row_acc ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(row_acc, fn {val, col_index}, col_acc ->
        if val == "@" do
          Map.put(col_acc, {col_index, row_index}, true)
        else
          col_acc
        end
      end)
    end)
  end
end
