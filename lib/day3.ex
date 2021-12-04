defmodule Day3 do
  def file do
    "~/aoc/aoc21/day3.txt"
  end

  def run do
    file() |> parse() |> solve()
  end

  def run2 do
    file() |> parse() |> solve2
  end

  def parse(path) do
    Path.expand(path)
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def solve(binaries) do
    frequencies = calculate_frequencies(binaries)
    gamma = get_rate(frequencies, :gamma)
    epsilon = get_rate(frequencies, :epsilon)
    gamma * epsilon
  end

  def solve2(binaries) do
    freq = calculate_frequencies(binaries) |> Enum.with_index()

    m = map_binaries(binaries)
    filter(freq, m, :oxygen)
  end

  def map_binaries(binaries) do
    binaries |> Enum.map(&(&1 |> String.codepoints() |> Enum.with_index()))
  end

  def filter([{map, idx} | _], mapped_binaries, type) do
    {bit_criteria, _} = rate(map, type)

    r = mapped_binaries |> Enum.filter(&Enum.member?(&1, {bit_criteria, idx}))

    freq = recalculate_frequencies(r)
    {r, freq}
  end

  def filter([], mapped_binaries, _) do
    mapped_binaries
  end

  defp calculate_frequencies(binaries) do
    binaries
    |> Enum.flat_map(&(&1 |> String.codepoints() |> Enum.with_index()))
    |> Enum.group_by(fn {_, idx} -> idx end)
    |> Enum.map(fn {_, list} ->
      list
      |> Enum.flat_map(&(&1 |> Tuple.delete_at(1) |> Tuple.to_list()))
      |> Enum.frequencies()
    end)
  end

  defp recalculate_frequencies(binaries) do
    binaries
    |> Enum.to_list()
    |> List.flatten()
    |> Enum.group_by(fn {_, idx} -> idx end)
    |> Enum.map(fn {_, list} ->
      list
      |> Enum.flat_map(&(&1 |> Tuple.delete_at(1) |> Tuple.to_list()))
      |> Enum.frequencies()
    end)
    |> Enum.with_index()
    |> Enum.drop(1)
  end

  defp get_rate(frequencies, rate) do
    frequencies
    |> Enum.map(&(&1 |> rate(rate) |> Tuple.delete_at(1) |> Tuple.to_list()))
    |> List.flatten()
    |> List.to_string()
    |> String.to_integer(2)
  end

  defp rate(map, :gamma), do: Enum.max_by(map, fn {_, y} -> y end)
  defp rate(map, :epsilon), do: Enum.min_by(map, fn {_, y} -> y end)
  defp rate(map, :oxygen), do: Enum.max_by(map, fn {_, y} -> y end)
  defp rate(map, :co2), do: Enum.min_by(map, fn {_, y} -> y end)
end
