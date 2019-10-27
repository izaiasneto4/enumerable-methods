# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif arg.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i.is_a(arg) }
    end
    true
  end
end
