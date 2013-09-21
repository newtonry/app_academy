def remix(ingredients)
  alcohol = []
  mixer = []
  ingredients.each do |pair|
    alcohol << pair[0]
    mixer << pair[1]
  end
  alcohol.shuffle!.zip(mixer.shuffle!)
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])