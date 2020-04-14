module Mim
  class Printer
    def initialize(input, command, position, window)
      @input = input
      @command = command
      @position = position
      @window = window || Curses::Window.new(0,0,0,0)
    end

    def perform
      return unless @position
      case @command
      when /^v.*/
        set_visual_selection
      else
        set_cursor_position
      end
    end

    def set_visual_selection
      # cursor position will be set to default i.e. at the end of the output.
      # print the selection with best highlight
      @window.attrset(Curses::A_STANDOUT)
      @window.addstr(@input.slice(@position[0]..@position[1]))
      # print the rest of the input with normal text
      @window.attrset(Curses::A_NORMAL)
      @window.addstr(@input.slice(@position[1] + 1, @input.length - 1))
    end

    def set_cursor_position
      @window.addstr(@input)
      @window.setpos(@window.cury, @position[1])
    end
  end
end
