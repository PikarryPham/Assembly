#include "Header.h"

vector<unsigned short> magture(long Int, vector<unsigned short>& mod) {
	//vector<unsigned short> mod;

	while (Int != 0)
	{

		mod.insert(mod.begin(), Int % 2);
		Int /= 2;
	}
	return mod;
}

char epKieuReverse(int num)
{
	if (num >= 0 && num <= 9)
		return (char)(num + '0');
	else
		return (char)(num - 10 + 'A');
}

// reverse a string
void reverse(char* str)
{
	int len = strlen(str);
	int i;
	for (i = 0; i < len / 2; i++)
	{
		char temp = str[i];
		str[i] = str[len - i - 1];
		str[len - i - 1] = temp;
	}
}

char* fromDeci(char* stringAfter, int base, long long inputNum)
{
	int index = 0;
	while (inputNum > 0)
	{
		stringAfter[index++] = epKieuReverse(inputNum % base);
		inputNum /= base;
	}
	stringAfter[index] = '\0';
	// dao nguoc lai chuoi
	reverse(stringAfter);
	return stringAfter;

}

long long int changeIntoBase10(char* str, int base)
{
	long long int temp = 0;
	int sign = 1;
	for (int i = 0; i < strlen(str); ++i)
	{
		if (str[i] < 'A')
			temp = temp + ((int)str[i] - 48) * pow(base, strlen(str) - i - 1);
		else
			if (str[i] < 'a')
				temp = temp + ((int)str[i] - 55) * pow(base, strlen(str) - i - 1);
			else
				temp = temp + ((int)str[i] - 87) * pow(base, strlen(str) - i - 1);
	}
	return temp;
}
