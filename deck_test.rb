require_relative 'deck.rb'

require 'minitest/autorun'

describe Deck do
	before(:each) do
		@deck = Deck.new
	end

	describe '#new' do
		it 'should fill a new deck with 52 cards' do
			@deck.cards_in_deck.must_equal(52)
		end
	end

	describe '#shuffle!' do
		it 'should randomly shuffle the cards' do
			@deck.shuffle!
			@deck.sorted?.must_equal(false)
		end

		it 'should use the set shuffle shuffle_algorithm if present' do
			called = false
			@deck.shuffle_algorithm = ->(deck) { called = true; deck }
			@deck.shuffle!
			called.must_equal(true)
		end

		it 'should use the provided shuffle algorithm' do
			called = false
			@deck.shuffle! {|deck| called = true; deck}
			called.must_equal(true)
		end
	end

	describe '#deal!' do
		it 'should deal a card' do
			card = @deck.deal!
			@deck.has_card?(card).must_equal(false)
		end

		it 'should raise an error when dealing more cards than are present' do
			lambda { @deck.deal!(53) }.must_raise(RuntimeError)
		end

		it 'should raise an error when asking for less than 1 card' do
			lambda { @deck.deal!(0) }.must_raise(RuntimeError)
		end
	end

	describe '#put_back!' do
		it 'should return a card to the deck' do
			card = @deck.deal!

			@deck.put_back!(card)
			@deck.cards_in_deck.must_equal(52)
		end

		it 'should only allow cards that have been dealt to be returned' do
			card = Card.new('test', 'test')

			lambda { @deck.put_back!(card) }.must_raise(RuntimeError)
		end
	end

	describe '#sort!' do
		it 'should sort the cards' do
			@deck.sort!

			@deck.sorted?.must_equal(true)
		end

		it 'should use the set sort_algorithm if present' do
			called = false
			@deck.sort_algorithm = ->(deck) { called = true; deck }
			@deck.sort!

			called.must_equal(true)
		end

		it 'should use the provied sort algorithm' do
			called = false
			@deck.sort! { |deck| called = true; deck }

			called.must_equal(true)
		end
	end
end
