def logo_print():
    print(""" _    _
| |  | |
| |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __
|  __  |/ _` | '_ \ / _` | '_ ` _ \ / _` | '_ \\
| |  | | (_| | | | | (_| | | | | | | (_| | | | |
|_|  |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
                     __/ |
                    |___/""", "\n", 6)


def choose_word(file_path, index):
    """
    :param file_path: a path to the file that contains the words that the user can choose from
    :param index: a number chosen by the user, that chooses the word in that index from the file
    :type file_path: str
    :type index: int
    :return: the secret word that the user will try to guess
    :rtype: str
    """
    with open(file_path) as file_input:
        str_txt = file_input.read()
        word_sep = str_txt.split(" ")

        if index <= len(word_sep): #if the number chosen by the user is <= to the amount of words in the file:
            secret_word = word_sep[index - 1] #the secret word is the one in the index chosen - 1, so the index will "start" at 1 and not 0
            return secret_word

        elif index > len(word_sep): #if the number chosen by the user is bigger then the amount of words in the file:
            secret_word = word_sep[(index - 1) - len(word_sep)] #the secret word will be the one in the index chosen by the user after the counting of the index will "loop"
            return secret_word


def hangman_status(num_of_tries):
    """
    :param num_of_tries: the number of tries that the user did
    :type num_of_tries: int
    :return: the value of the key (selected by the number of tries) that shows the hangman status
    :rtype: str
    """
    HANGMAN_PHOTOS = {}  # an empty dict that will be filled by the 7 photos below

    HANGMAN_PHOTOS[1] = "x-------x"

    HANGMAN_PHOTOS[2] = """x-------x
|
|
|
|
|"""

    HANGMAN_PHOTOS[3] = """x-------x
|       |
|       0
|
|
|"""

    HANGMAN_PHOTOS[4] = """x-------x
|       |
|       0
|       |
|
|"""

    HANGMAN_PHOTOS[5] = """x-------x
|       |
|       0
|      /|\\
|
|"""

    HANGMAN_PHOTOS[6] = """x-------x
|       |
|       0
|      /|\\
|      /
|"""

    HANGMAN_PHOTOS[7] = """x-------x
|       |
|       0
|      /|\\
|      / \\
|"""

    return HANGMAN_PHOTOS[num_of_tries]


def try_update_letter_guessed(letter_guessed, old_letters_guessed):
    """
    :param letter_guessed: the guess of the user
    :param old_letters_guessed: a list of old guesses
    :type letter_guessed: str
    :type old_letters_guessed: list
    :return: True if the guess is valid or not guessed before, False if the guess is not valid or guessed before.
    :rtype: bool
    """
    if len(letter_guessed) > 1 or letter_guessed.isalpha() == False: #if the guess was invalid
        print("X")
        seperator = ' -> ' #a seperator to use in the display of guessed letters
        lower_list = [x.lower() for x in old_letters_guessed] #making a new list that is the old guess list in lowercase
        old_letters_guessed = lower_list #make the old guess list == to the lower list
        print(seperator.join(sorted(old_letters_guessed, key=str.lower))) #sorting the list from small to big and adding an arrow between every letter
        return False

    elif letter_guessed in old_letters_guessed: #if the letter was guessed before. #same explanation as above
        print("X")
        seperator = ' -> '
        lower_list = [x.lower() for x in old_letters_guessed]
        old_letters_guessed = lower_list
        print(seperator.join(sorted(old_letters_guessed, key=str.lower)))
        return False

    elif len(letter_guessed) == 1 or letter_guessed.isalpha() == True: #if the guess was valid
        old_letters_guessed.append(letter_guessed)
        return True


def show_hidden_word(secret_word, old_letters_guessed):
    """
    :param secret_word: the word that the user needs to guess
    :param old_letters_guessed: a list of old letters that the user already guessed
    :type secret_word: str
    :type old_letters_guessed: list
    :return: the secret word with the letters that the user haven't guessed yet hidden (as "_")
    :rtype: str
    """
    user_guess_str = " " #a space that will be joined with the list of guessed letters to seperate them
    user_guess_list = [] #an empty list to add to letters that are both in the secret word and the old guess list
    for letter in secret_word:
        if letter in old_letters_guessed: #if the letter from the secret word is in the old letters list:
            user_guess_list.append(letter) #the letter is added to the empty guess list
        else: #if the letter of the secret word have not been guessed yet:
            user_guess_list.append("_") #an "_" is added to the empty guess list
    return user_guess_str.join(user_guess_list) #the empty list that been filled with the letters and "_" seperated by the guess str


def check_win(secret_word, old_letters_guessed):
    """
    :param secret_word: the word that the user needs to guess
    :param old_letters_guessed: a list of old letters that the user already guessed
    :type secret_word: str
    :type old_letters_guessed: list
    :return: True or False, depends if the secret word is equal to the users guess
    :rtype: bool
    """
    if secret_word == show_hidden_word(secret_word, old_letters_guessed).replace(" ", ""): #if the secret word equels to the users guess (without spaces):
        return True
    else:
        return False


def main():
    logo_print() #prints the start logo

    file_path = input("Enter a file path:")
    index = int(input("Enter an index:"))

    secret_word = choose_word(file_path, index) #the word from the file that is in the index chosen by the user

    old_letters_guessed = [] #an empty list to add to the users guess
    MAX_TRIES = 6 #the max number of tries the user gets
    num_of_tries = 0 #the starting number of tries

    print(hangman_status(num_of_tries + 1)) #showing the user the starting status of the hangman

    print(show_hidden_word(secret_word, old_letters_guessed)) #showing the user the amount of letters in the secret word (as "_")


    while num_of_tries != MAX_TRIES: #while the user still got "moves"
        letter_guessed = input("guess a letter:").lower()

        if try_update_letter_guessed(letter_guessed, old_letters_guessed) == True: #if the letter guessed is valid and not been guessed before

            if letter_guessed not in secret_word: #if the secret word does'nt contain the letter:
                print(":(")
                num_of_tries += 1 #adds one to the number of tries
                print(hangman_status(num_of_tries + 1)) #shows the user the new status
                print(show_hidden_word(secret_word, old_letters_guessed)) #shows the user the secret word status

            elif letter_guessed in secret_word: #if the secret word contains the letter:
                print(show_hidden_word(secret_word, old_letters_guessed)) #shows the user the secret word status

                if check_win(secret_word, old_letters_guessed) == True: #then, checking if the user already won
                    print("WIN")

        else: #if the guess was invalid:
            print(show_hidden_word(secret_word, old_letters_guessed))

    if num_of_tries == MAX_TRIES: #if the user didn't guess the word in the amount of tries given:
        print("LOSE")


if __name__ == '__main__':
    main()
