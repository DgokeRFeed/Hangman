# Класс, отвечающий за игровую логику приложения
class Game
  # Количество ошибок, которые игрок может совершить
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  # Метод возвращает массив из букв загаданого слова,
  # которые пользователь уже угадал. Если буква еще не угадана,
  # вместо нее возвращается nil
  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(normalize_letter(letter))
          letter
        else
          nil
        end
      end
    result
  end

  def lost?
    errors_allowed == 0
  end

  # Метод заменяет введенные игроком буквы Ё и Й на Е и И соответственно,
  # так как по правилам эти буквы эквивалентны
  def normalize_letter(letter)
    if letter == "Ё"
      "Е"
    elsif letter == "Й"
      "И"
    else
      letter
    end
  end

  # Метод заменяет буквы Ё и Й на Е и И в загаданном слове
  def normalized_letters
    result =
      @letters.map do |letter|
        normalize_letter(letter)
      end
    result
  end

  def over?
    won? || lost?
  end

  # Основной метод, переводящий игру в новое состояние.
  # Если игра не окончена и введенная буква не повторилась,
  # то игра переходит в следующее состояние (либо открывается новая буква,
  # либо дорисовывается виселица)
  def play!(letter)
    normalized_letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
