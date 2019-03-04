def c_cipher(string, shift_factor)

  if shift_factor > 26
    shift_factor = shift_factor % 26
  end

  string_array_form = string.split("")

  string_array_form.each_with_index do |item, index|
    string_array_form[index] = shift(item, shift_factor)
  end

  return string_array_form.join("")
end

def shift(char, shift_factor)

  # ----- setting up some dicts

  low_alphabet =  ('a'..'z').to_a
  high_alphabet = ('A'..'Z').to_a

  number_array_1 = (1..26).to_a
  number_array_2 = (1..26).to_a

  h1 = low_alphabet.zip(number_array_1).to_h
  h2 = high_alphabet.zip(number_array_2).to_h

  # -----

  if char.match(/[a-z]/)
    low_num1 = h1[char]
    low_num2 = low_num1 + shift_factor

    if low_num2 > 26
      low_num2 = low_num2 - 26
    end

    char = h1.key(low_num2)
    return char
  end

  if char.match(/[A-Z]/)
    high_num1 = h2[char]
    high_num2 = high_num1 + shift_factor

    if high_num2 > 26
      high_num2 = high_num2 - 26
    end

    char = h2.key(high_num2)
    return char
  end

  return char
end

puts "Enter a string to convert to Caeser's cypher:"
input_string = gets.chomp
puts "Enter the shift value:"
input_shift_factor = gets.chomp.to_i
puts c_cipher(input_string, input_shift_factor)
