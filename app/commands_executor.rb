# frozen_string_literal: true
require_relative './bitmap_creator'

class CommandsExecutor
  UNRECOGNISED_COMMAND = -> (_) { puts 'unrecognised command :(' }

  def initialize
    @mappings = {
      'I' => -> (args) { create_bitmap(args) },
      'C' => -> (_)    { clear_bitmap },
      'L' => -> (args) { color_pixel(args) },
      'V' => -> (args) { draw_vertical_line(args) },
      'H' => -> (args) { draw_horizontal_line(args) },
      'S' => -> (_)    { show_bitmap }
    }
  end

  def call(input)
    command, arguments = input.split(' ', 2)
    executor_for(command).call(arguments)
  rescue
    puts 'An error occured, please try again. Try `?` for help.'
  end

  private

  def create_bitmap(args)
    @bitmap = BitmapCreator.call(args)
  end

  def clear_bitmap
  end

  def color_pixel(args)
  end

  def draw_vertical_line(args)
  end

  def draw_horizontal_line(args)
  end

  def show_bitmap
  end

  def executor_for(command)
    mappings[command] || UNRECOGNISED_COMMAND
  end

  attr_reader :mappings
end
