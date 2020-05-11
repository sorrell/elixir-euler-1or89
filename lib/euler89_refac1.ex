defmodule Euler891 do

  def main() do
    Enum.count(1..10000, fn x -> check_num(x) == 89 end)
  end

  def check_num(num) do
    split_num(num)
    |> square_and_sum_numlist
    |> is1or89
  end

  def split_num(num) do
    String.split(Integer.to_string(num), "", trim: true)
    |> Enum.map(fn digit -> String.to_integer(digit) end)
  end

  def square_and_sum_numlist(list) do
    Enum.map(list, fn digit -> digit*digit end)
    |> Enum.sum()
  end

  def is1or89(num) do
    case num do
      1 -> 1
      89 -> 89
      _ -> check_num(num)
    end
  end

end
