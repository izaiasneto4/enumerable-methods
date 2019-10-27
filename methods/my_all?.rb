# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  def my_all?(arg = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif arg.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless i.is_a?(arg) }
    end
    true
  end
end

