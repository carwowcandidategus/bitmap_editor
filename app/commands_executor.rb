# frozen_string_literal: true
require_relative './bitmap_creator'

class CommandsExecutor
  UNRECOGNISED_COMMAND = -> (_) { puts 'unrecognised command :(' }
  BITMAP_NOT_YET_CREATED = 'No image created yet. Try `?` for help.'

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
    with_valid_bitmap do
      bitmap.each_index do |row|
        bitmap[0].each_index do |column|
          bitmap[row][column] = 0
        end
      end
    end
  end

  def color_pixel(args)
  end

  def draw_vertical_line(args)
  end

  def draw_horizontal_line(args)
  end

  def show_bitmap
    with_valid_bitmap do
      bitmap.each do |row|
        row.each do |element|
          print element
        end
        print "\n"
      end
    end
  end

  def with_valid_bitmap
    if bitmap
      yield
    else
      puts BITMAP_NOT_YET_CREATED
    end
  end

  def executor_for(command)
    mappings[command] || UNRECOGNISED_COMMAND
  end

  attr_reader :mappings, :bitmap
end
