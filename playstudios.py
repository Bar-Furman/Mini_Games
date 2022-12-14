import random


def sample_one(arr):
    """
    :param arr: a range between 1-10
    :type arr: list
    :return: a random number selected from the array
    :rtype: int
    """
    return random.choice(arr)
    # from an array of numbers, returning a specific number in random


def rand():
    """
    :return: a random number between 1-0
    :rtype: float
    """
    return random.random()
    # returning a float between 1-0 to use for the odds later on


def single_round(N, L, P, index):
    """
    :param N: the number of bushes
    :type N: int
    :param L: the length of a trampoline
    :type L: int
    :param P: the chance of the player to land on the surprise
    :type P: str
    :param index: the position of the surprise on the lower trampoline
    :type index: int
    :return: True if the Skydiver survives and False if he doesn't
    :rtype: bool
    """
    arr = range(1, N + 1)
    # creating the array of options for the skydiver
    tramp_up = []
    tramp_down = []
    # an empty list that represents the trampolines
    num1 = random.randint(1, L + 1)
    num2 = random.randint(1, L + 1)
    # marking the starting point of the trampoline in random between 1-5
    tramp_up.append(num1)
    tramp_down.append(num2)
    # adding the starting point of the trampoline to the empty lists

    i = 1
    while i < L:
        tramp_up.append(num1 + 1)
        tramp_down.append(num2 + 1)
        i += 1
        num1 += 1
        num2 += 1
    # a loop that has 4 rounds, each time adding the sequential number to the last number in each of the trampoline-
    # lists by that we're ending up with two trampoline lists, each with 5 sequential numbers in it between 1-10

    spec = tramp_down[index]
    # selecting a specific place on the lower trampoline and ,making it the position of the "special surprise"

    odds = (int(P.replace('%', '')) / 100)
    # converting P to a float number so we could use it in the odds

    dive_point = sample_one(arr)
    # naming the random number selected by the 'sample_one' function

    rand_flo = rand()
    # naming the random float selected by the 'rand()' function

    while odds < rand_flo:
        # while the odds (which are 25%) are SMALLER than the random float between 1-0, the loop will operate (by-
        # doing that the player has 25% chance)
        if dive_point == spec:
            return 5
        elif dive_point in (tramp_up or tramp_down):
            return 1
        elif dive_point not in (tramp_up or tramp_down):
            return 0
    # returns 5 if the "dive_point" is the same as the "special surprise", 1 if the "dive_point" is within any of the-
    # trampoline lists and 0 if the "dive_point" is outside the trampoline lists range

    while odds > rand_flo:
        # while the odds (which are 25%) are BIGGER than the random float between 1-0, the loop will operate (by doing-
        # that the player has 25% chance)
        dive_point = spec
        # the row above is irrelevant but does exists for the concept
        return 5
    # returns 5 because the "dive_point" is the same as the "special surprise"


def main():
    N = 10
    L = 5
    P = "25%"
    index = 0
    # all the parameters are for example
    print(single_round(N, L, P, index))


if __name__ == '__main__':
    main()
