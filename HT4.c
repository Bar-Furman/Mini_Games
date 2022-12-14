#include<stdio.h>
#include<stdlib.h>

//func 1:
//---------------------------------------------------------------------------------------------------
char* LongestWord(char *str)
{
	char *longest_word;
	int counter = 0, max = 0, j = 0, index = 0, i;
	for (i = 0; str[i] != '\0'; i++)
	{
		counter++;
		if (str[i] == ' ')
		{
			if (counter > max)
			{
				max = counter;
				index = i - max + 1;
			}
			counter = 0;
		}
	}
	if (counter >= max)
	{
		max = counter;
		index = i - counter;
	}
	longest_word = (char*)malloc((max + 1) * sizeof(char));
	for (i = 0; str[index] != ' ' && str[index] != '\0'; i++, index++)
		longest_word[i] = str[index];
	longest_word[i] = '\0';
	return longest_word;
}
//---------------------------------------------------------------------------------------------------

//func 2:
//---------------------------------------------------------------------------------------------------
char* nWord(char *str, int n)
{
	int i, counter = 0, t = 0, j = 0, k = 0;
	char *n_word;
	for (i = 0;counter < n - 1;i++)
	{
		if (str[i] == ' ')
			counter++;
	}
	k = i;
	for (i;str[i] != ' ' && str[i] != '\0';i++)
		t++;
	n_word = (char*)malloc((t + 1) * sizeof(char));
	for (k;str[k] != '\0' && str[k] != ' ';k++, j++)
	{
		n_word[j] = str[k];
	}
	n_word[j] = '\0';
	return n_word;

}

//---------------------------------------------------------------------------------------------------

//func 3:
//---------------------------------------------------------------------------------------------------
void ReadArr(int arr[], int n)
{
	printf("Enter %d integers:\n", n);
	for (int i = 0; i < n; i++)
		scanf_s("%d", &arr[i]);
}

float* Middle(int *arr, int n)
{
	float *float_arr;
	int i, j;
	float_arr = (float*)malloc((n - 1) * sizeof(float));
	for (i = 1, j = 0; i < n; i++, j++)
		float_arr[j] = (float)(arr[i] + arr[i - 1]) / 2;
	return float_arr;
}

//---------------------------------------------------------------------------------------------------


void main()
{
	int choice = 0; //for switch
	char str[51], *longest_word; //func 1
	char /*str[51],*/ *n_word;//func 2 uses the same str[51] as func 1
	//int n; //func 2 uses the same n as func 3
	int n; //func 3
	float *arr;//func 3

	printf("WELCOME TO TASK 4!\n------------------");
	while (choice != 4)
	{
		printf("\nChoose which part you'd like to check:\n1. The Longest Word checker\n2. The Word in the Spot\n3. The The middle of the X's\nOr...\n4. Exit the program\n");
		scanf_s("%d", &choice);

		switch (choice)
		{
		case 1: //the main of func 1
			printf("Enter a sentence, the output will be the longest word:\n");
			getchar();
			gets(str);
			longest_word = LongestWord(str);
			printf("The longest word in the sentence is:\n");
			puts(longest_word);
			free(longest_word);

			break;

		case 2: //the main of func 2
			printf("Please enter a sentence:\n");
			getchar();
			gets(str);
			printf("Please enter a n spot:\n");
			scanf_s("%d", &n);
			n_word = nWord(str, n);
			printf("The word in spot %d is:\n", n);
			puts(n_word);
			free(n_word);

			break;

		case 3: //the main of func 3
			printf("Enter number of integers on X axis:\n");
			scanf_s("%d", &n);
			arr = (float*)malloc(n * sizeof(float));
			ReadArr(arr, n);
			arr = Middle(arr, n);
			printf("The middle of adjacent numbers on X axis is:\n");
			for (int i = 0; i < n - 1; i++)
				printf("%.1f\t", arr[i]);

			putchar('\n');
			break;

		case 4: //Exit option
			printf("\nThank you for using, hope everything was alright!\nBye Bye\n");
			break;

		default:printf("Ileagal Input\n");
		}
	}
}