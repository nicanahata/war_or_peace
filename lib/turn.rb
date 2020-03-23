class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      if player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
        :mutually_assured_destruction
      else
        :war
      end
    end
  end

  def winner
    if type == :basic
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1
      else
        player2
      end
    elsif type == :war
      if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
        player1
      else
        player2
      end
    elsif type == :mutually_assured_destruction
      "No winner"
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << player1.deck.cards.first
      player1.deck.cards.shift
      @spoils_of_war << player2.deck.cards.first
      player2.deck.cards.shift
    elsif type == :war
      player1.deck.cards.first(3).each do |card|
        @spoils_of_war << card
        player1.deck.cards.shift(3)
      end
      player2.deck.cards.first(3).each do |card|
        @spoils_of_war << card
        player2.deck.cards.shift(3)
      end
    elsif type == :mutually_assured_destruction
      player1.deck.cards.shift(3)
      player2.deck.cards.shift(3)
      end
    end

    def award_spoils(winner)
      @spoils_of_war.each do |spoilwar|
        winner.deck.cards << spoilwar
      end
      @spoils_of_war = []
    end

  end
