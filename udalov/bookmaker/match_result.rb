class MatchResult
  attr_reader :host_score, :guest_score

  def initialize(score_str)
    @host_score, @guest_score = parse_score_from(score_str)
  end

  def outcome
    return :draw     if draw?
    return :host_win if host_win?
    :guest_win
  end

  def ==(other)
    return false unless other.is_a?(MatchResult)
    host_score == other.host_score && guest_score == other.guest_score
  end

  private

  def parse_score_from(score_str)
    match = score_str.match(/^(-?\d+):(-?\d+)$/)

    raise ArgumentError, "Неверный формат: '#{score_str}'" unless match

    host, guest = match[1].to_i, match[2].to_i
    raise ArgumentError, "Счёт не может быть отрицательным" if host < 0 || guest < 0

    [host, guest]
  end

  def draw?
    host_score == guest_score
  end

  def host_win?
    host_score > guest_score
  end
end
