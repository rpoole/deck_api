class Card
	attr_reader :suit, :value
	include Comparable

	SUITS = %w[heart spade diamond club]
	VALUES = %w[2 3 4 5 6 7 8 9 10 jack queen king ace]

	VALUE_MAP = {
		'jack' => 11,
		'queen' => 12,
		'king' => 13,
		'ace' => 14,
	}

	def initialize(suit, value)
		@suit = suit
		@value = value

		self
	end

	def value_int
		comparison_val = @suit.to_i
		comparison_val = VALUE_MAP[@suit] if comparison_val == 0
	end

	def <=>(other)
		self.value_int <=> other.value_int
	end

	def ==(other)
		self.class == other.class && self.state == other.state
	end
	alias_method :eql?, :==

	protected

	def state
		[@suit, @value]
	end
end
