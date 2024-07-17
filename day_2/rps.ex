defmodule RPS do

  def score(game) do
    case game do
      "A X" -> 4
      "A Y" -> 8
      "A Z" -> 3
      "B X" -> 1
      "B Y" -> 5
      "B Z" -> 9
      "C X" -> 7
      "C Y" -> 2
      "C Z" -> 6
    end
  end

  def score_2(game) do
    case game do
      "A X" -> 3
      "A Y" -> 4
      "A Z" -> 8
      "B X" -> 1
      "B Y" -> 5
      "B Z" -> 9
      "C X" -> 2
      "C Y" -> 6
      "C Z" -> 7
    end
  end

end

# part 1
# input = IO.read(:stdio, :eof)
#   |> String.split("\n")
#   |> Enum.map(&RPS.score/1)
#   |> Enum.sum

# part 2
input = IO.read(:stdio, :eof)
  |> String.split("\n")
  |> Enum.map(&RPS.score_2/1)
  |> Enum.sum

IO.puts(input)
