defmodule SupplyStacks do

  def process_input(lines, options \\ []) do
    [s, i] = lines
    |> String.split("\n\n")
    #|> Enum.filter(fn s -> not String.match?(s, ~r/^#/) end)
    stacks = SupplyStacks.parse_stacks(s)
    instructions = SupplyStacks.parse_instructions(i)
    SupplyStacks.process(stacks, instructions, options)
    |> SupplyStacks.get_tops()
  end

  def get_tops(stacks) do
    Enum.join(Enum.map(stacks, &List.last/1),"")
  end

  @doc """
  Parses the raw stacks format and returns a list of lists, one for each stack
  The last element in each list is on top of the stack

  ## Examples
  iex> SupplyStacks.parse_stacks("    [D]    \\n[N] [C]    \\n[Z] [M] [P]\\n 1   2   3 ")
  [["Z", "N"], ["M", "C", "D"], ["P"]]
  iex> SupplyStacks.parse_stacks("                [V]     [C]     [M]")
  [[],[],[],[],["V"],[],["C"],[],["M"]]
  """
  def parse_stacks(stacks) do
    stack_row_r = ~r/(\s{3}|\[[A-Z]\])\s?/
    String.split(stacks, "\n")
    |> Enum.filter(fn s -> String.match?(s, ~r/\[/) end)
    |> Enum.map(fn s -> Regex.scan(stack_row_r, s, capture: :first) end)
    |> Enum.map(&List.flatten/1)
    |> Enum.map(fn r -> Enum.map(r, &String.trim/1) end)
    |> List.zip()
    |> Enum.map(fn r -> Enum.reverse(Tuple.to_list(r))
    |> Enum.filter(fn c -> String.length(c) > 1 end) end)
    |> Enum.map(fn r -> Enum.map(r, fn e -> String.replace(e, ~r"[\[\]]", "") end) end)
  end

  @doc """
  Parses the raw instructions format and returns a list of tuples of instructions

  ## Examples
  iex> SupplyStacks.parse_instructions("move 1 from 2 to 1\\nmove 3 from 1 to 3\\nmove 2 from 2 to 1\\nmove 10 from 8 to 1")
  [{1, 2, 1}, {3, 1, 3}, {2, 2, 1}, {10, 8, 1}]
  """
  def parse_instructions(instructions) do
    instruction_r = ~r/^move (\d+) from (\d+) to (\d+)$/
    String.split(instructions, "\n")
    |> Enum.map(fn s -> Regex.scan(instruction_r, s) end)
    |> Enum.map(&List.flatten/1)
    |> Enum.map(fn r -> Enum.map(Enum.slice(r,1..-1), &String.to_integer/1) end)
    |> Enum.map(&List.to_tuple/1)
  end


  @doc """
  Returns the resulting stack after applying all instructions

  """
  def process(stacks, instructions, options) do
    Enum.reduce(instructions, stacks, fn i,s ->
      SupplyStacks.apply(s, i, options)
    end)
  end

    @doc """
  Returns the resulting stack after applying instruction

  ## Examples
  iex> SupplyStacks.apply([["Z", "N"], ["M", "C", "D"], ["P"]], {1, 2, 1})
  [["Z", "N", "D"], ["M", "C"], ["P"]]
  iex> SupplyStacks.apply([["Z", "N"], ["M", "C", "D"], ["P"]], {2, 2, 1})
  [["Z", "N", "D", "C"], ["M"], ["P"]]
  """
  def apply(stacks, instruction, options \\ []) do
    {num_blocks, from_index, to_index} = instruction
    reverse = Keyword.get(options, :reverse, true)
    m = Enum.with_index(stacks, fn element, index -> %{index+1 => element} end)
    |> Enum.reduce(%{}, &Map.merge/2)
    # get value to move
    val = Enum.take(m[from_index],-num_blocks)
    # drop it from old stack
    m = %{ m | from_index => Enum.drop(m[from_index],-num_blocks)}
    # move it to new stack, optionally reversing order
    m =  if reverse do
      %{ m | to_index => m[to_index] ++ Enum.reverse(val)}
    else
      %{ m | to_index => m[to_index] ++ val}
    end
    Map.to_list(m)
    |> Enum.map(fn e -> {_i, a} = e; a end)
  end


end
