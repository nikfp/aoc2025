defmodule Part1 do
  def solve(input) do
    [shapes, boxes ] = input
    
    boxes 
    |> Enum.filter(fn %{size: size, index_list: ilist} -> 
      ilist
      |> Enum.map(fn {count, index} -> 
        count * Map.get(shapes, index)
      end)
      |> Enum.sum()
      |> case do
        val when val > size -> false
        _val -> true
      end
    end)
    |> Enum.count()
  end
end
