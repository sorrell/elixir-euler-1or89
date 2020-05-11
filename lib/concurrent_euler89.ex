defmodule ConEuler89 do

  @iterations 10000

  def main() do
    begin = :os.system_time(:millisecond)
    pid = spawn(ConEuler89, :start, [self()])
    Enum.count(1..@iterations, fn x -> spawn(ConEuler89, :check_num, [x, pid]) end)
    ending = :os.system_time(:millisecond)
    t = (ending - begin) / 1000
    print_stats(t)
  end

  def print_stats(t) do
    receive do
      {:stats, {total_count, count89}} -> "Found #{count89} results in #{total_count} comps in #{t} seconds"
      {:ok, num} -> num
    end
  end

  def check_num(num, pid) do
    case comp = compute_num(num) do
      89 -> send(pid, {:num89, comp})
      _  -> send(pid, {:other, comp})
    end
  end

  def start(parent_pid) do
    total_count = 0
    count89 = 0
    loop({total_count, count89, parent_pid})
  end

  #when total_count <= @iterations
  def loop({total_count, count89, parent_pid}) do
    {total_count, count89, parent_pid} = receive do
      {:num89, num} -> {total_count + 1, count89 + 1, parent_pid}
      {:other, num} -> {total_count + 1, count89, parent_pid}
    end
    case total_count do
      @iterations -> send(parent_pid, {:stats, {total_count, count89}})
      _ -> loop({total_count, count89, parent_pid})
    end
  end

  def compute_num(num) do
    String.split(Integer.to_string(num), "", trim: true)
    |> Enum.map(fn digit -> String.to_integer(digit) end)
    |> Enum.map(fn digit -> digit*digit end)
    |> Enum.sum()
    |> is1or89
  end

  def is1or89(num) do
    case num do
      1 ->  1
      89 -> 89
      _ -> compute_num(num)
    end
  end

end
