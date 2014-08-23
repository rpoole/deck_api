require_relative 'deck.rb'

require 'minitest/autorun'

describe Deck do
	describe '#shuffle' do
		it 'should randomly shuffle the cards'
		it 'should use the set shuffle shuffle_algorithm if present'
		it 'should use the provided shuffle algorithm'
	end

	describe '#deal' do
		it 'should only deal 52 cards max'
		it 'should use the set deal_algorithm if present'
		it 'should use the provided deal algorithm'
	end

	describe '#put_back' do
		it 'should return a card to the deck'
		it 'should only allow cards that have been dealt to be returned'
		it 'should use the set put_back_algorithm if present'
		it 'should use the provided put back algorithm'
	end

	describe '#sort' do
		it 'should sort the cards'
		it 'should use the set sort_algorithm if present'
		it 'should use the provied sort algorithm'
	end
end
