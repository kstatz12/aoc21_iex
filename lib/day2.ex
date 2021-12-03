defmodule Day2 do
  def file do
    "~/aoc/aoc21/day2.txt"
  end

  def parse(path) do
    Path.expand(path)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn x -> Enum.chunk_every(x, 2) |> Map.new(fn [k, v] -> {k, v} end) end)
  end

  def solve([h | t], {x, y}) do
    case h do
      %{"forward" => m} -> solve(t, {x + String.to_integer(m), y})
      %{"up" => m} -> solve(t, {x, y - String.to_integer(m)})
      %{"down" => m} -> solve(t, {x, y + String.to_integer(m)})
    end
  end

  def solve([], {x, y}) do
    x * y
  end

  def solve([h | t], {x, y, z}) do
    case h do
      %{"forward" => m} -> solve(t, {x + String.to_integer(m), y + z * String.to_integer(m), z})
      %{"up" => m} -> solve(t, {x, y, z - String.to_integer(m)})
      %{"down" => m} -> solve(t, {x, y, z + String.to_integer(m)})
    end
  end

  def solve([], {x, y, _}) do
    x * y
  end
end
