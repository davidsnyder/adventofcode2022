defmodule SupplyStacksTest do
  use ExUnit.Case, async: true
  doctest SupplyStacks

  @sample_input_filename "test/fixtures/sample_input.txt"
  @input_filename "test/fixtures/input.txt"

  test "[part 1] handles sample input and returns correct answer" do
    sample_input_path = Path.expand(@sample_input_filename, File.cwd!)
    {:ok, sample_input} = File.read(sample_input_path)
    result = SupplyStacks.process_input(sample_input, reverse: true)
    assert result == "CMZ"
  end

  test "[part 1] handles input and returns correct answer" do
    input_path = Path.expand(@input_filename, File.cwd!)
    {:ok, input} = File.read(input_path)
    result = SupplyStacks.process_input(input, reverse: true)
    assert result == "JRVNHHCSJ"
  end

  test "[part 2] handles sample input and returns correct answer" do
    sample_input_path = Path.expand(@sample_input_filename, File.cwd!)
    {:ok, sample_input} = File.read(sample_input_path)
    result = SupplyStacks.process_input(sample_input, reverse: false)
    assert result == "MCD"
  end

  test "[part 2] handles input and returns correct answer" do
    input_path = Path.expand(@input_filename, File.cwd!)
    {:ok, input} = File.read(input_path)
    result = SupplyStacks.process_input(input, reverse: false)
    assert result == "GNFBSBJLH"
  end

end
