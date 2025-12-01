defmodule Part1 do
  # Input comes in as [{"L/R", Integer}, ...]
  def solve(input) do
    {_, zero_count} =
      input
      |> Enum.map(fn {dir, count} -> {dir, Integer.mod(count, 100)} end)
      |> Enum.reduce({50, 0}, fn el, {dial_pos, count} ->
        turn_dial(el, dial_pos)
        |> case do
          val when val == 0 -> {val, count + 1}
          val -> {val, count}
        end
      end)

    zero_count
  end

  defp turn_dial({"L", count}, dial_pos) do
    (dial_pos - count)
    |> case do
      val when val >= 0 -> val
      val -> 100 - abs(val)
    end
  end

  defp turn_dial({"R", count}, dial_pos) do
    (dial_pos + count)
    |> case do
      val when val > 99 -> Integer.mod(val, 100)
      val -> val
    end
  end
end
