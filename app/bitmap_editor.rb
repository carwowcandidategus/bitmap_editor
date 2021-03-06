# frozen_string_literal: true
require_relative './commands_executor'

class BitmapEditor
  def initialize
    @commands_executor = CommandsExecutor.new
  end

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      process(gets.chomp)
    end
  end

  private

  def process(input)
    case input
    when '?'
      show_help
    when 'X'
      exit_console
    else
      commands_executor.call(input)
    end
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end

  attr_reader :commands_executor
end
