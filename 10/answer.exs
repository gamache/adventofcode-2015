defmodule Day10 do
  ## Hey README, don't fucking tell me what I have to do iteratively or not

  def encode("", output_str, last_char_count, last_char) do
    "#{output_str}#{last_char_count}#{last_char}"
  end

  def encode(str, output_str, last_char_count, last_char) do
    first = String.first(str)
    rest = String.slice(str, 1..-1)
    if first == last_char do
      encode(rest, output_str, last_char_count+1, last_char)
    else
      encode(rest, "#{output_str}#{last_char_count}#{last_char}", 1, first)
    end
  end

  def encode(str), do: encode(str, "", "", "")

  def encode_n_times(str, 0), do: str

  def encode_n_times(str, n), do: encode_n_times(encode(str), n-1)
end

"1321131112"
|> Day10.encode_n_times(40)
|> String.length
|> IO.puts

