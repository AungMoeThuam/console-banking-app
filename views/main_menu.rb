require "io/console"

TERMINAL_WIDTH = IO.console.winsize[1]
def center_text(text,split)
  terminal_width = TERMINAL_WIDTH #get the current width of the windows
  # Calculate padding needed to center the text
  padding = (terminal_width - text.length) / 2
  puts split * padding + text + split * padding
end

def border(text)
  terminal_width = TERMINAL_WIDTH
  padding = (TERMINAL_WIDTH - text.length) / 2
  top_border = "-" * terminal_width
  bottom_border = "-" * terminal_width
  left_border = "|" + " " * (padding - 1)
  right_border = " " * (padding - 1) + "|"
  puts top_border
  puts left_border + text + right_border
  puts bottom_border
end

def main_menu
  border("AM Banking App")
  center_text("Welcome"," ")
  puts "1: login"
  puts "2: new user"
  puts "3: exit"
end
main_menu