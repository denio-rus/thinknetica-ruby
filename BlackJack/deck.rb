class Deck
  #   def self.all_cards
  #     %w[2+ 3+ 4+ 5+ 6+ 7+ 8+ 9+ 10+ J+ Q+ K+ A+
  #        2^ 3^ 4^ 5^ 6^ 7^ 8^ 9^ 10^ J^ Q^ K^ A^
  #        2<3 3<3 4<3 5<3 6<3 7<3 8<3 9<3 10<3 J<3 Q<3 K<3 A<3
  #        2<> 3<> 4<> 5<> 6<> 7<> 8<> 9<> 10<> J<> Q<> K<> A<>]
  #   end
  def self.all_cards
    %w[A+ A- A% A<> A? A A A J 5]
  end

  def initialize
    @deck = self.class.all_cards.shuffle
  end

  def give_card
    deck.shift
  end

  private

  attr_reader :deck
end
