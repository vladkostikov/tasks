# frozen_string_literal: true

require_relative '../look_and_say'

describe LookAndSay do
  before(:all) do
    @look_and_say = LookAndSay.new
  end

  it 'returns default initial sequence' do
    result = @look_and_say.calculate_sequence_for_line(1)

    expect(result).to eq '1'
  end

  it 'returns not default initial sequence' do
    initial_sequence = '567'
    look_and_say = LookAndSay.new(initial_sequence)
    result = look_and_say.calculate_sequence_for_line(1)

    expect(result).to eq initial_sequence
  end

  it 'returns sequences' do
    correct_sequences = %w[1 11 21 1211 111221 312211 13112221]

    correct_sequences.each_with_index do |sequence, i|
      result = @look_and_say.calculate_sequence_for_line(i + 1)

      expect(sequence).to eq result
    end
  end

  it 'calculates second sequence for not default initial sequence' do
    initial_sequence = '567'
    look_and_say = LookAndSay.new(initial_sequence)
    result = look_and_say.calculate_sequence_for_line(2)

    expect(result).to eq '151617'
  end

  it 'prints sequences' do
    correct_output = "1. 1\n2. 11\n3. 21\n4. 1211\n"

    expect { @look_and_say.print_sequences(4) }
      .to output(correct_output).to_stdout
  end

  it 'calculates 10th sequence' do
    correct_tenth_sequence = '13211311123113112211'
    result = @look_and_say.calculate_sequence_for_line(10)

    expect(result).to eq correct_tenth_sequence
  end

  it 'returns nil for line < 1' do
    result = @look_and_say.calculate_sequence_for_line(0.99)

    expect(result).to eq nil
  end

  it 'saves sequences to array' do
    @look_and_say.calculate_sequence_for_line(5)
    sequences = @look_and_say.sequences

    expect(sequences.size).to be >= 5
  end
end
