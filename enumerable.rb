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
end
