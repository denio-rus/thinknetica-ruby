class Game
  attr_reader :player, :dealer, :interface, :screen

  def initialize
    @interface = Interface.new
    name = interface.request_name
    @player = Player.new(name)
    @screen = {}
  rescue RuntimeError => e
    interface.error(e)
    retry
  end

  def play
    self.dealer = Dealer.new
    self.bank = Bank.new
    screen['player'] = player.name
    screen['dealer'] = dealer.name
    loop do
      start_round
      round_winner = play_round
      interface.round_end(round_winner)
      break if winner?
    end
    game_over
  end

  private

  attr_accessor :player_hand, :dealer_hand, :deck, :bank
  attr_writer :player, :dealer

  def game_over
    interface.end_game(winner)
    input = interface.request_another_game
    if input == 'y'
      play
    else
      exit
    end
  end

  def start_round
    bank.bet
    self.deck = Deck.new
    card1 = deck.give_card
    card2 = deck.give_card
    self.player_hand = Hand.new(card1, card2)
    card1 = deck.give_card
    card2 = deck.give_card
    self.dealer_hand = DealerHand.new(card1, card2)
    screen['player_money'] = bank.player_money
    screen['dealer_money'] = bank.dealer_money
    screen['bank'] = bank.game_bank
  end

  def play_round
    loop do
      screen['player_hand'] = player_hand.show_cards
      screen['dealer_hand'] = dealer_hand.show_cards
      screen['player_points'] = player_hand.total_points
      screen['dealer_points'] = '???'
      interface.card_table(screen)
      case interface.round_menu
      when 1
        dealer_move
      when 2
        take_card
        return open_card if player_hand.total_points > 21
        dealer_move
      when 3
        return open_card
      end
      return open_card if player_hand.cards_number == 3 && dealer_hand.cards_number == 3
    end
  end

  def dealer_move
    dealer_move = dealer.make_decision(dealer_hand)
    if dealer_move == 'take'
      card = deck.give_card
      dealer_hand.take(card)
      interface.comment(dealer.name, :take)
    else
      interface.comment(dealer.name, :pass)
    end
  end

  def take_card
    player_hand.take(deck.give_card)
    screen['player_hand'] = player_hand.show_cards
    screen['player_points'] = player_hand.total_points
    interface.card_table(screen)
  rescue RuntimeError => e
    interface.error(e)
  end

  def winner?
    if bank.player_money == 200 || bank.dealer_money == 200
      true
    else
      false
    end
  end

  def winner
    return player.name if bank.player_money == 200
    dealer.name if bank.dealer_money == 200
  end

  def open_card
    screen['dealer_hand'] = dealer_hand.open
    screen['dealer_points'] = dealer_hand.total_points
    interface.card_table(screen)
    player_result = player_hand.total_points
    dealer_result = dealer_hand.total_points
    if player_result > 21 || dealer_result > player_result && dealer_result <= 21
      bank.dealer_win
      return dealer.name
    elsif player_result > dealer_result || dealer_result > 21
      bank.player_win
      return player.name
    else
      bank.draw
      return
    end
  end
end
