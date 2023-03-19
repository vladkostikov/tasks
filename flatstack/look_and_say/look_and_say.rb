class LookAndSay
  attr_accessor :sequences

  def initialize(initial_sequence = '1')
    @sequences = [initial_sequence]
  end

  def print_sequences(lines)
    # Сначала рассчитываем последовательности
    calculate_sequence_for_line(lines)

    # Затем печатаем
    sequences.first(lines).each_with_index do |sequence, i|
      puts "#{i + 1}. #{sequence}"
    end
  end

  # Рассчитываем последовательности и добавляем в массив до нужной строки
  def calculate_sequence_for_line(line)
    return nil if line < 1

    index = line - 1
    sequences << next_sequence(sequences.last) until sequences[index]
    sequences[index]
  end

  private

  # Рассчитываем следующую последовательность на основе известной
  def next_sequence(current_sequence)
    char_counter = 1
    next_sequence = ''

    i = 0
    while current_sequence[i]
      current_char = current_sequence[i]
      next_char = current_sequence[i + 1]

      if current_char == next_char
        char_counter += 1
      else
        next_sequence << char_counter.to_s << current_char
        char_counter = 1
      end
      i += 1
    end

    next_sequence
  end
end
