require_relative 'card.rb'

class Deck
	DECK_SIZE = Card::SUITS.length * Card::VALUES.length

	attr_reader :shuffle_algorithm, :sort_algorithm, :sorted

	def initialize
		@cards = []
		@dealt_cards = []
		fill_deck

		self
	end

	def cards_in_deck
		@cards.length
	end

	def cards_dealt
		@dealt_cards.length
	end

	def sorted?
		!!@sorted
	end

	def has_card?(card)
		@cards.include?(card)
	end

	def sort_algorithm=(algo)
		if valid_lambda?(algo)
			@sort_algorithm = algo
		else
			raise "You must provide a valid sort_algorithm"
		end
	end

	def shuffle_algorithm=(algo)
		if valid_lambda?(algo)
			@shuffle_algorithm = algo
		else
			raise "You must provide a valid shuffle_algorithm"
		end
	end

	def shuffle!
		if block_given?
			yield(@cards)
		elsif @shuffle_algorithm
			@shuffle_algorithm.call(@cards)
		else
			default_shuffle
		end

		@sorted = false
		self
	end

	def deal!(count=1)
		raise "You must deal at least 1 card." if count < 1
		raise "No cards left to deal." if @cards.length < count

		(@dealt_cards << @cards.pop(count)).flatten!

		return @dealt_cards.last if count == 1
	end

	def put_back!(cards)
		raise "Cannot return a card that has not been dealt yet." unless @dealt_cards.include?(cards)

		cards = [cards].flatten

		@sorted = false
		(@cards << cards).flatten!
		@dealt_cards.reject! {|card| cards.include?(card)}

		self
	end

	def sort!
		if block_given?
			yield(@cards)
		elsif @sort_algorithm
			@sort_algorithm.call(@cards)
		else
			default_sort
		end

		@sorted = true
		self
	end

	private

	def fill_deck
		Card::SUITS.each do |suit|
			Card::VALUES.each do |value|
				@cards << Card.new(suit, value)
			end
		end
	end

	def default_shuffle
		@cards.shuffle!
	end

	def default_sort
		sort_map = Hash.new{|h,k| h[k] = []}

		@cards.each do |card|
			# could write algo to insert cards in sorted
			# order to make faster, but that's a future
			# optimization
			sort_map[card.suit] << card
		end

		@cards = sort_map.each_value.map(&:sort!).reduce(&:concat)
	end

	def valid_lambda?(arg)
		arg && arg.respond_to?(:lambda?) && arg.lambda?
	end
end
