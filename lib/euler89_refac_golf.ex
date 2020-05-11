defmodule Euler89G do

  def main() do
    c = Enum.count(1..10000, fn x -> check_num(x) == 89 end)
  end

  def check_num(num) do
    String.split(Integer.to_string(num), "", trim: true)
    |> Enum.map(fn digit -> String.to_integer(digit) end)
    |> Enum.map(fn digit -> digit*digit end)
    |> Enum.sum()
    |> is1or89
  end

  def is1or89(num) do
    case num do
      1 -> 1
      89 -> 89
      _ -> check_num(num)
    end
  end

end
