# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < length
      yield at i
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    counter = 0
    i = 0
    while i < length
      yield(at(i), counter)
      counter += 1
      i += 1
    end
    self
  end

  def my_map
    return to_enum unless block_given?

    array = []
    my_each { |i| array << yield(i) }
    array
  end

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

  def my_any?(arg = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif arg.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if i.is_a?(arg) }
    end
    false
  end

  def my_count(num = nil)
    count = 0
    if num
      my_each { |elem| count += 1 if elem == num }
    elsif block_given?
      my_each { |elem| count += 1 if yield(elem) }
    else
      count = length
    end
    count
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif arg.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i.is_a?(arg) }
    end
    true
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_inject(arg_1 = nil, arg_2 = nil)
    array = to_a.dup
    (inject, sym, array) = get_inject_and_sym(arg_1, arg_2, array, block_given?)
    if sym
      inject = inject_sym(array, sym, inject)
    else
      array[0..-1].my_each { |i| inject = yield(inject, i) }
    end
    inject
  end

  def get_inject_and_sym(arg1, arg2, arr, block)
    inject_and_sym = if arg1.nil?
                       [arr.shift, nil, arr]
                     elsif arg2.nil? && !block
                       [arr.shift, arg1, arr]
                     elsif arg2.nil? && block
                       [arg1, nil, arr]
                     else
                       [arg1, arg2, arr]
                     end
    inject_and_sym
  end

  def inject_sym(array, sym, inject)
    array[0..-1].my_each { |i| inject = inject.send(sym, i) }
    inject
  end
end

def multiply_els
  array.my_inject { |mul, n| mul * n }
end
