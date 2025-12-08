defmodule Part2 do
  def solve(input) do
    input
    |> Enum.reverse()
    |> Stream.map(&String.split(&1, "", trim: true))
    |> Stream.map(&Enum.reverse(&1))
    |> Enum.zip_reduce({0, []}, &process_line/2)
    |> elem(0)
  end

  defp process_line([" " | digits], {sum, collected_digits}) do
    number =
      digit_strings_to_number(digits)

    case number do
      0 -> {sum, collected_digits}
      val -> {sum, [val | collected_digits]}
    end
  end

  defp process_line(["*" | digits], {sum, collected_digits}) do
    number =
      digit_strings_to_number(digits)

    digits_sum = [number | collected_digits] |> Enum.product()
    {sum + digits_sum, []}
  end

  defp process_line(["+" | digits], {sum, collected_digits}) do
    number =
      digit_strings_to_number(digits)

    digits_sum = [number | collected_digits] |> Enum.sum()

    {sum + digits_sum, []}
  end

  defp digit_strings_to_number(digits_list) do
    digits_list
    |> Stream.reject(&(&1 == " "))
    |> Stream.map(&String.to_integer(&1))
    |> Enum.reverse()
    |> Integer.undigits()
  end
end
