require_relative './match_result'

class Bet
  attr_reader :prediction

  def initialize(score_str)
    @prediction = MatchResult.new(score_str)
  end

  def score_for(actual_result)
    return 1 if prediction == actual_result
    return 0 if prediction.outcome == actual_result.outcome
    -1
  end
end

