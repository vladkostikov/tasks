# frozen_string_literal: true

require_relative '../bet'

RSpec.describe Bet do
  describe '#score_for' do
    context 'когда прогноз точный' do
      it 'возвращает 1' do
        actual = MatchResult.new('2:2')
        bet = Bet.new('2:2')
        expect(bet.score_for(actual)).to eq(1)
      end
    end

    context 'когда прогноз неправильный' do
      it 'возвращает -1' do
        actual = MatchResult.new('2:2')
        bet = Bet.new('3:1')
        expect(bet.score_for(actual)).to eq(-1)
      end
    end

    context 'когда прогноз по исходу совпадает, но счёт другой' do
      it 'возвращает 0 для ничьи' do
        actual = MatchResult.new('2:2')
        bet = Bet.new('1:1')
        expect(bet.score_for(actual)).to eq(0)
      end

      it 'возвращает 0 для победы хозяев' do
        actual = MatchResult.new('3:1')
        bet = Bet.new('2:0')
        expect(bet.score_for(actual)).to eq(0)
      end

      it 'возвращает 0 для победы гостей' do
        actual = MatchResult.new('0:2')
        bet = Bet.new('1:3')
        expect(bet.score_for(actual)).to eq(0)
      end
    end

    context 'когда входные данные некорректны' do
      it 'выбрасывает ArgumentError для неверного формата' do
        expect { Bet.new('abc') }.to raise_error(ArgumentError, /Неверный формат/)
        expect { Bet.new('0') }.to raise_error(ArgumentError, /Неверный формат/)
        expect { Bet.new('0.0') }.to raise_error(ArgumentError, /Неверный формат/)
        expect { Bet.new('0,0') }.to raise_error(ArgumentError, /Неверный формат/)
        expect { Bet.new('0;0') }.to raise_error(ArgumentError, /Неверный формат/)
      end

      it 'выбрасывает ArgumentError при отрицательных числах' do
        expect { Bet.new('-1:0') }.to raise_error(ArgumentError, /отрицательным/)
        expect { Bet.new('0:-1') }.to raise_error(ArgumentError, /отрицательным/)
      end
    end
  end
end