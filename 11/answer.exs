defmodule Day11 do
  def has_straight?(str) do
    straight_run(str, "", 0, 0) >= 3
  end

  def doesnt_have_iol?(str) do
    !String.match?(str, ~r"[iol]")
  end

  def has_two_pairs?(str) do
    count_pairs(str, 0) >= 2
  end

  defp count_pairs("", pairs), do: pairs
  defp count_pairs(str, pairs) do
    first = String.first(str)
    second = String.slice(str, 1..1)
    if first == second do
      count_pairs(String.slice(str, 2..-1), pairs+1)
    else
      count_pairs(String.slice(str, 1..-1), pairs)
    end
  end

  ## returns the length of the longest straight (e.g., "zzzbcdexy" is 4)
  defp straight_run("", _prev_char, _current_run, best_run), do: best_run
  defp straight_run(str, prev_char, current_run, best_run) do
    first = String.first(str)
    rest = String.slice(str, 1..-1)
    if first == char_after(prev_char) and first != "a" do
      if current_run >= best_run do
        straight_run(rest, first, current_run+1, current_run+1)
      else
        straight_run(rest, first, current_run+1, best_run)
      end
    else
      straight_run(rest, first, 1, best_run)
    end
  end

  defp char_after(""), do: nil
  defp char_after("z"), do: "a"
  defp char_after(str_char) do
    [ 1 + (str_char |> String.to_char_list |> Enum.at(0)) ] |> to_string
  end

  ## increments the string, e.g. "ab" becomes "ac", "az" becomes "ba"
  defp increment(str) do
    first_chars = str |> String.slice(0..-2)
    last_char = str |> String.slice(-1..-1)
    if last_char == "z" do
      increment(first_chars) <> "a"
    else
      first_chars <> char_after(last_char)
    end
  end


  def next_password(current_password) do
    next = increment(current_password)
    if has_straight?(next) and doesnt_have_iol?(next) and has_two_pairs?(next) do
      next
    else
      next_password(next)
    end
  end
end


"hepxcrrq"
|> Day11.next_password
|> IO.puts


