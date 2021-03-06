require 'byebug'
require 'curses'

module Mim
  require_relative 'mim/executor.rb'
  require_relative 'mim/printer.rb'
  require_relative 'mim/exceptions/invalid_input_exception.rb'
  require_relative 'mim/exceptions/invalid_length_exception.rb'
  require_relative 'mim/exceptions/unknown_command_exception.rb'
end

begin
  Curses.init_screen
  Curses.start_color
  Curses.use_default_colors
  Curses.nocbreak
  Curses.echo
  Curses.curs_set(1)
  window = Curses::Window.new(0,0,0,0)
  window.addstr('Input:')
  input = window.getstr
  window.getstr
  window.addstr('Command:')
  command = window.getstr

  while !['exit', 'q'].include?(command) do
    executor = Mim::Executor.new(input)
    # perofrm returns position of the cursor OR
    # part of the input text to be highlighted
    position = executor.perform(command)

    printer = Mim::Printer.new(input, command, position, window)
    printer.perform

    window.getstr
    window.addstr('Command:')
    command = window.getstr
  end
ensure
  window.close
  Curses.close_screen
end
