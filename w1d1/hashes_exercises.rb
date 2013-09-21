def set_add_el hash, element
  hash[element] = true
  hash
end

def set_remove_el hash, element
  hash.delete(element)
  hash
end

def set_list_els hash
  hash.keys
end

def set_member? hash, element
  hash.has_key?(element)
end

def set_union hash1, hash2
  hash1.merge(hash2)
end

def set_intersection hash1, hash2
  intersects_array = hash1.select do |k,v|
    hash2.has_key?(k)
  end
end

def set_minus hash1, hash2
  hash1.reject do |k,v|
    hash2.has_key?(k)
  end
end



def correct_hash(wrong_hash)
  output = {}
  wrong_hash.each do |k, v|
    output[v[0].to_sym] = v
  end

  output
end



p correct_hash(wrong_hash = { :a => "banana", :b => "cabbage", :c => "dental_floss", :d => "eel_sushi" })


# p set_minus({:x => true, :y => true}, {:z => true, :x => true})


#p set_union({:x => true}, {:y => true})

#p set_member?({:x => true}, :x)
#p set_list_els({:x => true, :y => true})

#puts set_remove_el({:x => true}, :x)

#puts set_add_el({}, :x)
#puts set_add_el({:x => true}, :x)