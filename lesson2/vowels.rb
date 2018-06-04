alphabet = ("a".."z")
vowel = ["a", "e", "i", "o", "u", "y"]
vowels = {}

alphabet.each.with_index(1) { |letter, index| vowels[letter] = index if vowel.include?(letter) }

puts vowels

# Dторой метод тоже можно применить, просто надо +1 к счетчику прописатью.
# Я так понимаю лучше использовать по возможности один метод, а не два для выполнения аналогичных действий.
alphabet.each_with_index { |letter, index| vowels[letter] = index + 1 if vowel.include?(letter) }

puts vowels
