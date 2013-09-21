def looper
  i = 0
  until i > 250 and i % 7 == 0
    i += 1
  end
  return i
end

p looper