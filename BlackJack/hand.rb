class Hand
  attr_reader :hand

  def initialize(card1, card2)
    @hand = [card1, card2]
  end

  def show_cards
    hand.join('|')
  end

  def cards_number
    hand.size
  end

  def take(card)
    raise 'Разрешено сдавать не более 3 карт' if cards_number == 3
    @hand << card
  end

  def total_points
    sum = 0
    got_ace = false
    double_aces = false
    hand.each do |card|
      number = points(card)
      if number == 'A' && !got_ace
        got_ace = true
      elsif number == 'A' && got_ace
        double_aces = true
        got_ace = false # при появлении третьего туза отработают sum_with_ace и sum_with_double_aces
      else
        sum += number
      end
    end
    sum = sum_with_double_aces(sum) if double_aces
    sum = sum_with_ace(sum) if got_ace
    sum
  end

  def sum_with_ace(sum)
    if (sum + 11) > 21
      sum + 1
    else
      sum + 11
    end
  end

  def sum_with_double_aces(sum)
    return 12 if cards_number == 2 || sum == 10 # если третья карта 10 или картинка то тузы по 1
    sum + 12
  end

  def points(card)
    first_sym = card[0]
    if first_sym.to_i > 1 # numbers 2..9
      first_sym.to_i
    elsif first_sym == 'A'
      'A'
    elsif %w[1 J Q K].include?(first_sym)
      10 # 10 and pictures
    end
  end
end
