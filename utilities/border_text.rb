require "io/console"

def border_text(text)
  terminal_width = IO.console.winsize[1]
  padding = (terminal_width - text.length) / 2
  top_border = "-" * terminal_width
  bottom_border = "-" * terminal_width
  left_border = "|" + " " * (padding - 1)
  right_border = " " * (padding - 1) + "|"
  puts top_border
  puts left_border + text + right_border
  puts bottom_border
end