# typed: true
# frozen_string_literal: true

# Helper methods for formatting terminal output.
module Formatter
  module_function

  # Format a headline string with arrow prompt.
  def arrow(string, color: :bold)
    "#{Tty.send(color)}==>#{Tty.reset} #{string}"
  end

  # Format a main headline string.
  def headline(string, color: :bold)
    "#{Tty.send(color)}==> #{string}#{Tty.reset}"
  end

  # Format a success message string.
  def success(string, color: :green)
    "#{Tty.send(color)}#{string}#{Tty.reset}"
  end

  # Format an error message string with red prefix.
  def error(string, color: :red)
    "#{Tty.send(color)}Error:#{Tty.reset} #{string}"
  end

  # Format a warning message string with yellow prefix.
  def warning(string, color: :yellow)
    "#{Tty.send(color)}Warning:#{Tty.reset} #{string}"
  end
end