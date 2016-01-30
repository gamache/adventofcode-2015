defmodule Day04 do
  def mine(key, i \\ 1) do
    hash = "#{key}#{i}" |> hex_md5
    case hash do
      "00000" <> _rest -> i
      _ -> mine(key, i+1)
    end
  end

  def hex_md5(string) do
    :crypto.hash(:md5, string)
    |> :erlang.binary_to_list                                # list of 0..255
    |> Enum.map(fn(b) -> :erlang.integer_to_list(b, 16) end) # list of '0'..'FF'
    |> Enum.map(fn(h) -> String.downcase(to_string(h)) end)  # list of "0".."ff"
    |> Enum.map(fn(h) -> if String.length(h) == 1, do: "0"<>h, else: h end) # list of "00".."ff"
    |> Enum.join
  end
end

"iwrupvqb"
|> Day04.mine
|> IO.puts

