defmodule Euler89 do

  def main() do
    rng = 1..10000
    Enum.count(rng, fn x -> check_num(x) == 89 end)
  end

  def check_num(num) do
    num
    |> split_num
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

  def is1or89(num) when num == 1 do
    1
  end
  def is1or89(num) when num == 89 do
    89
  end
  def is1or89(num) do
    check_num(num)
  end
end
