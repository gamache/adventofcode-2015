defmodule Day09 do

  ## Returns distances map
  def parse(string_block) do
    string_block
    |> String.rstrip
    |> String.split("\n")
    |> Enum.reduce(%{}, fn (str, ds) -> store_distance(str, ds) end)
  end

  ## "Faerun to Tristram = 65" becomes {"Faerun", "Tristram", 65}
  defp parse_line(str) do
    [from_to, distance_str] = str |> String.split(" = ")
    [from, to] = from_to |> String.split(" to ")
    {from, to, String.to_integer(distance_str)}
  end

  ## distances["Faerun"]["Tristram"] == distances["Tristram"]["Faerun"] == 65
  defp store_distance(str, distances) do
    {from, to, distance} = parse_line(str)
    from_distances = distances |> Map.get(from, %{}) |> Map.put(to, distance)
    to_distances = distances |> Map.get(to, %{}) |> Map.put(from, distance)

    distances |> Map.put(from, from_distances) |> Map.put(to, to_distances)
  end

  def permutations([]), do: [[]]

  def permutations(list) do
    for h <- list, t <- permutations(list -- [h]), do: [h | t]
  end

  ## returns {distance, route}
  def shortest_route(distances) do
    distances
    |> Map.keys
    |> permutations
    |> Enum.reduce({nil, []}, fn (route, {best_distance, best_route}) ->
         d = route_distance(distances, route)
         if is_nil(best_distance) || d < best_distance do
           {d, route}
         else
           {best_distance, best_route}
         end
       end)
  end

  ## returns integer distance of route
  defp route_distance(distances, route) do
    route
    |> Enum.reduce({nil, 0}, fn (next_loc, {last_loc, distance}) ->
         if is_nil(last_loc) do
           {next_loc, distance}
         else
           {next_loc, distance + distances[last_loc][next_loc]}
         end
       end)
    |> elem(1)
  end

end


"""
Faerun to Tristram = 65
Faerun to Tambi = 129
Faerun to Norrath = 144
Faerun to Snowdin = 71
Faerun to Straylight = 137
Faerun to AlphaCentauri = 3
Faerun to Arbre = 149
Tristram to Tambi = 63
Tristram to Norrath = 4
Tristram to Snowdin = 105
Tristram to Straylight = 125
Tristram to AlphaCentauri = 55
Tristram to Arbre = 14
Tambi to Norrath = 68
Tambi to Snowdin = 52
Tambi to Straylight = 65
Tambi to AlphaCentauri = 22
Tambi to Arbre = 143
Norrath to Snowdin = 8
Norrath to Straylight = 23
Norrath to AlphaCentauri = 136
Norrath to Arbre = 115
Snowdin to Straylight = 101
Snowdin to AlphaCentauri = 84
Snowdin to Arbre = 96
Straylight to AlphaCentauri = 107
Straylight to Arbre = 14
AlphaCentauri to Arbre = 46
"""
|> Day09.parse
|> Day09.shortest_route
|> IO.inspect

