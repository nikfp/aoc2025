defmodule Part2 do
  def solve(input) do
    input
    |> Stream.flat_map(&get_invalid_ids/1)
    |> Enum.sum()
  end

  defp get_invalid_ids([low, high]) do
    low..high
    |> Enum.filter(&check_is_invalid/1)
  end

  defp check_is_invalid(number) do
    digit_list =
      number
      |> Integer.to_string()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer(&1))

    list_length = digit_list |> length()
    half_length = list_length |> div(2)

    # only try to test for a match if the half length is at least 1 
    # single digit numbers aren't long enough to meet criteria
    if half_length > 0 do
      1..half_length
      # Only need to get 1 hit, so reduce until possibilities are 
      # exhausted or the first hit is reached
      |> Enum.reduce_while(false, fn x, acc ->
        # if list length cannot be evenly divided by value, 
        # criteria cannot be met. Continue to next iteration.
        if rem(list_length, x) != 0 do
          {:cont, acc}
        else
          digit_list
          # chunk list by value, then dedup
          |> Stream.chunk_every(x)
          |> Stream.dedup()
          # deduped list will have a count of 1 if it's a match
          |> Enum.count()
          |> case do
            1 -> {:halt, true}
            _ -> {:cont, acc}
          end
        end
      end)
    else
      false
    end
  end
end
