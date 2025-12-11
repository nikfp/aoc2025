defmodule Part1 do
  def solve(input) do
    # Input arrives as: 
    # [
    #   %{
    #     lights: [Integer, ...],
    #     switches: [[Integer, ...], ...]
    #     joltages: [Integer, ...]
    #   }, ...
    # ]
    input
    # |> Enum.take(1)
    |> Enum.map(fn %{lights: lights, switches: switches} ->
      off_state_lights =
        lights
        |> Enum.map(fn _ -> 0 end)

      check_switches(MapSet.new([off_state_lights]), switches, lights, 0)
    end)
    |> Enum.sum()
  end

  defp check_switches(%MapSet{} = initial_list, switch_change_list, target_lights, count) do
    MapSet.to_list(initial_list)
    # Go through initial list. For each entry, 
    # check against the switch change list for the output. 
    # if the output matches the target, halt and return the count
    # if the output doesn't match, continue while accumulating
    # the results into a mapset.  
    |> Enum.reduce_while(MapSet.new(), fn initial_state, outer_acc ->
      switch_change_list
      |> Enum.reduce_while(outer_acc, fn switch, inner_acc ->
        new_config = switch_lights(initial_state, switch)

        if new_config == target_lights do
          {:halt, true}
        else
          {:cont, MapSet.put(inner_acc, new_config)}
        end
      end)
      |> case do
        true -> {:halt, true}
        val -> {:cont, val}
      end
    end)
    |> case do
      true ->
        count + 1

      val ->
        check_switches(val, switch_change_list, target_lights, count + 1)
    end
  end

  defp switch_lights(initial_state, switch) do
    Enum.reduce(switch, initial_state, fn index, state ->
      List.update_at(state, index, fn
        0 -> 1
        1 -> 0
      end)
    end)
  end
end
