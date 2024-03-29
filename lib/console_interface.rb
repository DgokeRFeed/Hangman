require "colorize"

# Класс, ответственный за вывод игровых элементов на экран
class ConsoleInterface
    # Массив картинок виселицы, собирающийся из текстовых файлов по пути /data/figures
  FIGURES =
      Dir["#{__dir__}/../data/figures/*.txt"].
      sort.
      map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  # Основной метод, собирающий все части интерфейса вместе и выводящий на экран
  def print_out
    puts <<~END

      Слово: #{word_to_show}
      #{figure.colorize(:cyan)}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts "Поздравляем, вы выиграли!".colorize(:light_green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:light_red)
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  # Метод выводит слово, которое игрок должен угадать
  # Если буква еще не угадана, на ее месте выводится "__"
  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          "__"
        else
          letter
        end
      end

    result.join(" ").colorize(:yellow)
  end

  def errors_to_show
    @game.errors.join(", ").colorize(:light_red)
  end

  def get_input
    print "Введите следующую букву: "
    letter = gets[0].upcase
    letter
  end
end
