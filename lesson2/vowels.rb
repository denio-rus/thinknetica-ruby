alphabet = ("a".."z")
vowel = ["a", "e", "i", "o", "u", "y"]
vowels = {}
number = 1

alphabet.each do |letter|
  vowels[letter] = number if vowel.include?(letter)
  number += 1
end
puts vowels
