defmodule CampCleanup do

  # part 1
  def process_subset(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&CampCleanup.parse/1)
    |> Enum.map(&CampCleanup.is_subset?/1)
    |> Enum.map(fn n -> if n do 1 else 0 end end)
    |> Enum.sum
  end

  # part 2
  def process_overlap(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&CampCleanup.parse/1)
    |> Enum.map(&CampCleanup.has_overlap?/1)
    |> Enum.map(fn n -> if n do 1 else 0 end end)
    |> Enum.sum
  end

  def parse(assignments) do
    String.split(assignments, ",")
    |> Enum.map(&CampCleanup.to_set/1)
  end

  @doc """
  Returns true if one assignment is contained within the other assignment

  ## Examples
  iex> CampCleanup.is_subset?([MapSet.new([2, 3, 4]), MapSet.new([6, 7, 8])])
  false
  iex> CampCleanup.is_subset?([MapSet.new([2, 3, 4]), MapSet.new([3, 4])])
  true
  """
  def is_subset?(assignments) do
    [left, right] = assignments
    MapSet.subset?(left, right) or MapSet.subset?(right, left)
  end

    @doc """
  Returns true if one assignment overlaps the other assignment

  ## Examples
  iex> CampCleanup.has_overlap?([MapSet.new([2, 3, 4]), MapSet.new([6, 7, 8])])
  false
  iex> CampCleanup.has_overlap?([MapSet.new([2, 3, 4]), MapSet.new([3, 4])])
  true
  """
  def has_overlap?(assignments) do
    [left, right] = assignments
    not MapSet.disjoint?(left, right)
  end

  @doc """
  Converts an assignment to a MapSet

  ## Examples
  iex> CampCleanup.to_set("2-4")
  MapSet.new([2, 3, 4])
  iex> CampCleanup.to_set("6-8")
  MapSet.new([6, 7, 8])
  """
  def to_set(assignment) do
    String.split(assignment,"-")
    |> Enum.map(&String.to_integer/1)
    |> create_range()
    |> Enum.to_list
    |> Enum.into(MapSet.new)
  end

  defp create_range(args) do
    apply(Range, :new, args)
  end

end
