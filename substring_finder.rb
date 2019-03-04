string = "Hi there! Howd Howyou thereno no?"
dictionary = ["Hi", "how", "there", "no"]
hesh = { }

dictionary.each do | substring |

  key = substring

  if string.scan(/#{substring}/i).size != 0
    hesh[key] = string.scan(/#{substring}/i).size
  end

  puts hesh

end
