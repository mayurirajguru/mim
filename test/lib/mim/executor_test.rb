require 'minitest/autorun'

require_relative '../../../lib/mim/executor'
require_relative '../../../lib/mim/exceptions/invalid_input_exception'
require_relative '../../../lib/mim/exceptions/invalid_length_exception'
require_relative '../../../lib/mim/exceptions/unknown_command_exception'

Dir.glob('../../../lib/mim/exceptions/*.rb') { |f| require_relative f }

class Mim::ExecutorTest < Minitest::Test
  def test_invalid_input
    #expected_output = "Encountered Error: Input must consist of ascii characters only\n"
    assert_raises Mim::InvalidInputException do
      Mim::Executor.new("Hello World\u{666}").perform('$')
    end
  end

  def test_invalid_length
    #expected_output = "Encountered Error: Input length must be between 1 and 30 characters\n"
    assert_raises Mim::InvalidLengthException do
      Mim::Executor.new("Hello World Hello World Hello World").perform('$')
    end
  end

  def test_unknown_command
    expected_output = "Encountered Error: Unknown command\n"
    assert_output(expected_output) { Mim::Executor.new("Hello World").perform('random word') }
  end

  def test_command_0
    expected_position = [0, 0]
    assert_equal Mim::Executor.new("Hello World").perform('0'), expected_position
  end

  def test_command_dollar
    expected_position = [0, 10]
    assert_equal Mim::Executor.new("Hello World").perform('$'), expected_position
  end

  def test_command_match_char
    expected_position = [0, 5]
    assert_equal Mim::Executor.new("Hello World").perform('tw'), expected_position
  end

  def test_command_word_end
    expected_position = [0, 4]
    assert_equal Mim::Executor.new("Hello World").perform('e'), expected_position
  end

  def test_visual_select_all_text
    expected_visual_selection = [0, 10]
    assert_equal Mim::Executor.new("Hello World").perform('v$'), expected_visual_selection
  end

  def test_visual_select_word
    expected_visual_selection = [0, 4]
    assert_equal Mim::Executor.new("Hello World").perform('ve'), expected_visual_selection
  end

  def test_visual_select_char
    expected_visual_selection = [0, 5]
    assert_equal Mim::Executor.new("Hello World").perform('vtw'), expected_visual_selection
  end
end
