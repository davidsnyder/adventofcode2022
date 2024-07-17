defmodule PrioritiesTest do
  use ExUnit.Case, async: true
  doctest Priorities

  @sample_input_filename "test/fixtures/sample_input.txt"
  @input_filename "test/fixtures/input.txt"

  test "[part 1] handles sample input and returns correct answer" do
    sample_input_path = Path.expand(@sample_input_filename, File.cwd!)
    {:ok, sample_input} = File.read(sample_input_path)
    result = Priorities.process(sample_input)
    assert result == 157
  end

  test "[part 1] handles input and returns correct answer" do
    input_path = Path.expand(@input_filename, File.cwd!)
    {:ok, input} = File.read(input_path)
    result = Priorities.process(input)
    assert result == 7848
  end

  test "[part 2] handles sample input and returns correct answer" do
    sample_input_path = Path.expand(@sample_input_filename, File.cwd!)
    {:ok, sample_input} = File.read(sample_input_path)
    result = Priorities.process_group(sample_input)
    assert result == 70
  end

  test "[part 2] handles input and returns correct answer" do
    input_path = Path.expand(@input_filename, File.cwd!)
    {:ok, input} = File.read(input_path)
    result = Priorities.process_group(input)
    assert result == 2616
  end

end
