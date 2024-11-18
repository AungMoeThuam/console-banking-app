require "io/console"
def center_text(text,split)
  terminal_width = IO.console.winsize[1]
  # Calculate padding needed to center the text
  padding = (terminal_width - text.length) / 2
  puts split * padding + text + split * padding
end

