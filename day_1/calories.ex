defmodule Calories do

  def calculate(values) do
    values
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end
end

# part 1
# input = IO.read(:stdio, :eof)
#   |> String.split("\n\n")
#   |> Enum.map(&Calories.calculate/1)
#   |> Enum.max

# part 2
input = IO.read(:stdio, :eof)
   |> String.split("\n\n")
   |> Enum.map(&Calories.calculate/1)
   |> Enum.sort
   |> Enum.reverse
   |> Enum.take(3)
   |> Enum.sum

IO.puts(input)
