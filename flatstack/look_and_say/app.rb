require_relative './look_and_say'

class Main
  look_and_say = LookAndSay.new

  # Если программа запущена с аргументом, то печатаем все последовательности
  # до нужной строки и завершаем программу
  line_count = ARGV[0].to_i || nil
  if line_count >= 1
    look_and_say.print_sequences(line_count)
    exit
  elsif ARGV[0]
    raise ArgumentError, 'Аргумент должен быть больше или равен 1'
  end

  # Основной цикл
  loop do
    puts '',
         'Сколько строк последовательности "Посмотри и скажи" распечатать? ' \
         '(0 – для выхода)'
    line_count = $stdin.gets.to_i
    exit if line_count.zero?

    look_and_say.print_sequences(line_count)
  end
end
