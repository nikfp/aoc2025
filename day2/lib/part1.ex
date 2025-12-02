defmodule Part1 do
  def solve(input) do
    input
    |> Stream.flat_map(&get_invalid/1)
    |> Enum.sum()
  end

  defp get_invalid([low, high]) do
    low..high
    |> Enum.filter(&check_is_valid/1)
  end

  defp check_is_valid(number) do
    string = number |> Integer.to_string()

    # a string with uneven digit count can't match,
    # so exclude by default
    if string |> String.length() |> rem(2) != 0 do
      false
    else
      check_halfs_match(string)
    end
  end

  defp check_halfs_match(string) do
    len = String.length(string)
    half_length = trunc(len / 2)
    split_string = String.split(string, "", trim: true)
    # Split numerical string in half, preserving each half
    [first_half, second_half] = Enum.chunk_every(split_string, half_length)
    # compare halves, if they are equal it's a match
    first_half == second_half
  end
end
