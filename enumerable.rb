module Enumerable
  def my_each
    size = to_a.length
    index = 0

    if block_given?
      until index == size
        yield(to_a[index])
        index += 1
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    size = to_a.length
    index = 0

    if block_given?
      until index == size
        yield(to_a[index], index)
        index += 1
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      result = []
      to_a.my_each do |item|
        result.push(item) if yield(item) == true
      end
      result
    else
      to_enum(:my_each_with_index)
    end
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
end

array = [nil, false, true]
p array.my_any?
