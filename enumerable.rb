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
end

array = [2, 4, 1, 5, 3, 8, 9]
p array.my_select(&:even?)
