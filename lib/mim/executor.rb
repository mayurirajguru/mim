module Mim
  class Executor
    COMMANDS = ['0', '$', 'e', /^t(.)$/, 've', 'v$', /^vt(.)$/]

    def initialize(input)
      @input = input
    end

    def check_input_validity
      raise InvalidLengthException unless @input.length.between?(1, 30)
      raise InvalidInputException unless @input.ascii_only?
    end

    def perform(command)
      check_input_validity
      navigation_commands = ['0', '$', 'e', /^t(.)$/]
      visual_select_commands = ['ve', 'v$', /^vt(.)$/]
      @input_chars = @input.split('')

      case command
      when *navigation_commands
        navigate(command)
      when *visual_select_commands
        visual_select(command)
      else
        raise UnknownCommandException
      end
    rescue StandardError => e
      puts "Encountered Error: #{e.message}"
    end

    # calculate correct cursor position
    def navigate(command)
      @cursor_position = [0,0]
      case command
      when '0'
        navigate_to_begining
      when '$'
        navigate_to_end
      when 'e'
        navigate_to_word_boundary
      when /^t(.)$/
        navigate_to_char(command)
      end
      @cursor_position
    end

    # calculate the range of characters to be highlighted
    def visual_select(command)
      @visual_selection_range = [0,0]
      case command
      when 've'
        visual_select_word
      when 'v$'
        visual_select_input
      when /^vt(.)$/
        visual_select_char(command)
      end
      @visual_selection_range
    end

    def navigate_to_begining
      @cursor_position[1] = 0
    end

    def navigate_to_end
      @cursor_position[1] = @input_chars.size - 1
    end

    def navigate_to_char(command)
      char_to_find = command.scan(/^t(.)$/).flatten[0]
      first_occurance_after = @input =~ /#{char_to_find}/i
      @cursor_position[1] = first_occurance_after - 1 if first_occurance_after
    end

    def navigate_to_word_boundary
      word_boundary_position = (@input =~ /\s/)
      @cursor_position[1] = word_boundary_position - 1 if word_boundary_position
    end

    def visual_select_word
      first_word_start = @input =~ /\w/
      first_word_end = (@input =~ /\s/)
      first_word_end = first_word_end ? first_word_end - 1 : @input_chars.length - 1
      @visual_selection_range = [first_word_start, first_word_end]
    end

    def visual_select_input
      @visual_selection_range = [0, @input_chars.size - 1]
    end

    def visual_select_char(command)
      char_to_find = command.scan(/^vt(.)$/).flatten[0]
      first_occurance_after = (@input =~ /#{char_to_find}/i)
      @visual_selection_range = [0, first_occurance_after - 1] if first_occurance_after
    end
  end
end
