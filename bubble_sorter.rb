def bubble_sort(array)
  (array.length - 1).times do
    array.each_with_index do | value, index |
      if index < array.length - 1
        if value > array[index + 1]
          array[index], array[index + 1] = array[index + 1], array[index]
        end
      end
    end
  end
  puts array
end

bubble_sort([4,3,78,2,0,2])
