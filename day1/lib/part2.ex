defmodule Part2 do
  # Input comes in as [{"L/R", Integer}, ...]
  def solve(input) do
    {new_pos, zero_count} =
      input
      |> Enum.reduce({50, 0}, fn el, acc ->
        turn_dial(el, acc)
      end)

    {new_pos, zero_count}
  end

  defp turn_dial({"L", count}, {dial_pos, zero_count}) do
    (dial_pos - count)
    |> case do
      val when val > 0 ->
        {val, zero_count}

      val when val <= 0 ->
        crossings = abs(val) |> div(100)
        remainder = abs(val) |> rem(100)
         
        new_pos = case remainder do
          np when np == 0 -> 0 
          np -> 100 - np
        end

        add_one =
          case dial_pos do
            0 -> 0
            dial when dial > 0 -> 1
          end

        {new_pos, zero_count + crossings + add_one}
    end
  end

  defp turn_dial({"R", count}, {dial_pos, zero_count}) do
    (dial_pos + count)
    |> case do
      val when val > 99 ->
        crossings = div(val, 100)
        remainder = rem(val, 100)
        {remainder, zero_count + crossings}

      val ->
        {val, zero_count}
    end
  end
end
