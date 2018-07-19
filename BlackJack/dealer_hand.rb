class DealerHand < Hand
  def show_cards
    '*' * cards_number
  end

  def open
    hand.join('|')
  end
end
