def super_print (string, options = {})
  defaults = {
    :times => 1,
    :upcase => false,
    :reverse => false
  }
  options = defaults.merge(options)

  string = string * (options[:times])
  string.reverse! if options[:reverse]
  string.upcase! if options[:upcase]

  string

end

p super_print("Hello")                                    #=> "Hello"
p super_print("Hello", :times => 3)                       #=> "Hello" 3x
p super_print("Hello", :upcase => true)                   #=> "HELLO"
p super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"