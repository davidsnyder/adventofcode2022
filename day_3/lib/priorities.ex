defmodule Priorities do

  @ascii_A 65
  @ascii_a 97

  def process(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&Priorities.split_compartments/1)
    |> Enum.map(&Priorities.get_common_item/1)
    |> Enum.map(&Priorities.priority/1)
    |> Enum.sum
  end

  def process_group(lines) do
    lines
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(&Priorities.get_common_item/1)
    |> Enum.map(&Priorities.priority/1)
    |> Enum.sum
  end

  @doc """
  Get item in common between rucksack compartments

  ## Examples
  iex> Priorities.get_common_item(["vJrwpWtwJgWr","hcsFMMfFFhFp"])
  "p"
  iex> Priorities.get_common_item(["jqHRNqRjqzjGDLGL","rsFMfFZSrLrFZsSL"])
  "L"
  """
  def get_common_item(contents) do
    contents
    |> Enum.map(fn c ->
    c
    |> String.split("")
    |> Enum.filter(fn e -> String.length(e) == 1 end)
    |> Enum.into(MapSet.new)
    end)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list
    |> List.first
  end


  @doc """
  Split rucksack contents into two equal compartments

  ## Examples
  iex> Priorities.split_compartments("vJrwpWtwJgWrhcsFMMfFFhFp")
  ["vJrwpWtwJgWr","hcsFMMfFFhFp"]
  iex> Priorities.split_compartments("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL")
  ["jqHRNqRjqzjGDLGL","rsFMfFZSrLrFZsSL"]
  """
  def split_compartments(contents) do
    len = String.length(contents)
    first_half = String.slice(contents, 0..(trunc(len / 2)-1))
    last_half = String.slice(contents, (trunc(len / 2))..-1)
    [first_half, last_half]
  end

  @doc """
  Converts a letter to its integer priority

  ## Examples
  iex> Priorities.priority("a")
  1
  iex> Priorities.priority("z")
  26
  iex> Priorities.priority("A")
  27
  iex> Priorities.priority("Z")
  52
  """
  def priority(letter) do
    char = String.to_charlist(letter)
    lowercase = ~r/^[a-z]$/
    case String.match?(letter, lowercase) do
      true -> (hd(char) - @ascii_a) + 1
      _ -> (hd(char) - @ascii_A) + 26 + 1
    end
  end

end
