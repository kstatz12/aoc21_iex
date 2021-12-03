defmodule Day2 do
  def file do
    "~/aoc/aoc21/day2.txt"
  end

  def parse(path) do
    Path.expand(path)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn x ->
      Enum.chunk_every(x, 2) |> Map.new(fn [k, v] -> {k, String.to_integer(v)} end)
    end)
  end

  def solve([h | t], {x, y}) do
    case h do
      %{"forward" => m} -> solve(t, {x + m, y})
      %{"up" => m} -> solve(t, {x, y - m})
      %{"down" => m} -> solve(t, {x, y + m})
    end
  end

  def solve([], {x, y}) do
    x * y
  end

  def solve([h | t], {x, y, z}) do
    case h do
      %{"forward" => m} -> solve(t, {x + m, y + z * m, z})
      %{"up" => m} -> solve(t, {x, y, z - m})
      %{"down" => m} -> solve(t, {x, y, z + m})
    end
  end

  def solve([], {x, y, _}) do
    x * y
  end
end
