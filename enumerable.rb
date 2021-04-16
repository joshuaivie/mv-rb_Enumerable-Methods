module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size = to_a.length
    index = 0

    until index == size
      yield(to_a[index])
      index += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    size = to_a.length
    index = 0

    until index == size
      yield(to_a[index], index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    to_a.my_each do |item|
      result.push(item) if yield(item) == true
    end
    result
  end

  def my_all?(param = nil)
    result = true
    if block_given?
      to_a.my_each do |item|
        result = false if yield(item) == false
      end
    elsif param.nil? == false
      if param.instance_of?(Class)
        to_a.my_each do |item|
          result = false if item.is_a?(param) == false
        end
      elsif param.instance_of?(Regexp)
        to_a.my_each do |item|
          result = false if param.match?(item) == false
        end
      else
        to_a.my_each do |item|
          result = false unless item == param
        end
      end
    else
      to_a.my_each do |item|
        result = false if item.nil? || item == false
      end
    end
    result
  end

  def my_any?(param = nil)
    result = false
    if block_given?
      to_a.my_each do |item|
        result = true if yield(item) == true
      end
    elsif param.nil? == false
      if param.instance_of?(Class)
        to_a.my_each do |item|
          result = true if item.is_a?(param) == true
        end
      elsif param.instance_of?(Regexp)
        to_a.my_each do |item|
          result = true if param.match?(item) == true
        end
      else
        to_a.my_each do |item|
          result = true if item == param
        end
      end
    else
      to_a.my_each do |item|
        result = true unless item.nil? || item == false
      end
    end
    result
  end

  def my_none?(param = nil)
    result = true
    if block_given?
      to_a.my_each do |item|
        result = false if yield(item) == true
      end
    elsif param.nil? == false
      if param.instance_of?(Class)
        to_a.my_each do |item|
          result = false if item.is_a?(param) == true
        end
      elsif param.instance_of?(Regexp)
        to_a.my_each do |item|
          result = false if param.match?(item) == true
        end
      else
        to_a.my_each do |item|
          result = false if item == param
        end
      end
    else
      to_a.my_each do |item|
        result = false unless item.nil? || item == false
      end
    end
    result
  end

  def my_count?(param = nil)
    count = 0
    if block_given?
      to_a.my_each do |item|
        count += 1 if yield(item) == true
      end
    elsif param.nil? == false
      to_a.my_each do |item|
        count += 1 if item == param
      end
    else
      to_a.my_each do
        count += 1
      end
    end
    result
  end

  def my_map(param = nil)
    result_array = []

    if param
      to_a.my_each do |item|
        result_array.push(param.call(item))
      end
      result_array

    elsif block_given?
      to_a.my_each do |item|
        result_array.push(yield(item))
      end
      result_array

    else
      to_enum(:my_each)
    end
  end

  def my_inject(param_1 = nil, param_2 = nil)
    array = to_a

    if param_1 && param_2
      acumulator = param_1
      operator = param_2

      array.my_each do |item|
        acumulator = acumulator.send(operator, item)
      end
      acumulator

    elsif param_1 && param_2.nil? && !block_given?
      acumulator = array.shift
      operator = param_1

      array.my_each do |item|
        acumulator = acumulator.send(operator, item)
      end
      acumulator

    elsif block_given? && param_1
      acumulator = param_1

      array.my_each do |item|
        acumulator = yield(acumulator, item)
      end
      acumulator

    elsif block_given?
      acumulator = array.shift

      array.my_each do |item|
        acumulator = yield(acumulator, item)
      end
      acumulator

    else
      raise StandardError, 'wrong use'
    end
  end
end

def multiply_els(param)
  array = param.to_a
  array.my_inject(:*)
end
