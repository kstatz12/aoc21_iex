defmodule Day1 do
  def file do
    "~/aoc/aoc21/day1.txt"
  end

  def parse(path) do
    Path.expand(path)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def solve(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> a < b end)
  end

  def solve2(list) do
    list
    |> Enum.chunk_every(3, 1, [])
    |> Enum.map(&Enum.sum(&1))
    |> solve
  end
end
