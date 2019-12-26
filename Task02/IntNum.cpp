#include "IntNum.h"



IntNum::IntNum(string std)
{
	base_10_int = stol(std);
	if (std[0] == '1')
	{
		sign = '1';
		std[0] = '0';
		SignMagnitude = stol(std);
	}
	else
		SignMagnitude = base_10_int;
}

IntNum::IntNum()
{
	base_10_int = 0;
	sign = ' ';
}


IntNum::~IntNum()
{
}

int changIntoBase10(string str, int base)
{
	int temp = 0;
	int sign = 1;
	if (str[0] == 32)
	{
		sign = -1;
		str[0] = '0';
	}
	for (int i = 0; i < str.length(); ++i)
	{
		if (str[i] == 32)
			str.erase(i);
		if (str[i] < 'A')
			temp = temp + ((int)str[i] - 48) * pow(base, str.length() - i - 1);
		else
			if (str[i] < 'a')
				temp = temp + ((int)str[i] - 55) * pow(base, str.length() - i - 1);
			else
				temp = temp + ((int)str[i] - 87) * pow(base, str.length() - i - 1);
	}
	return temp;
}

bool IntNum::input()
{
	string tmp;
	cout << "Input Binary string: ";
	//cin.ignore(100,'\n');
	getline(cin, tmp);
	base_10_int = changIntoBase10(tmp, 2);
	if (tmp[0] == '1')
	{
		sign = '-';
		tmp[0] = '0';
		SignMagnitude = changIntoBase10(tmp, 2);
	}
	else
		SignMagnitude = base_10_int;

	return true;
}

void IntNum::outputBase()
{
	cout << "Base 2: " << bitset <8 * sizeof(base_10_int)>(base_10_int) << '\n';
	cout << "Base 8: " << oct << base_10_int << '\n';
	cout << "Base 10: " << dec << (unsigned int)base_10_int << " (usigned int) \n";
	cout << "Base 16: " << hex << base_10_int << '\n';
	cout << dec;
}

void IntNum::output(int n)
{
	//	outputBase();
	
	
	
}

int& IntNum::overK()
{
	int k = 2019;
	int temp = base_10_int;
	temp = temp - k;
	return temp;

	// TODO: insert return statement here
}

int IntNum::oneComplement()
{
	unsigned int dec = base_10_int;
	unsigned int temp = ~dec;
	return temp;
}

int IntNum::twoComplement()
{
	int dec = base_10_int;
	unsigned int temp = (~dec + 1);
	return temp;
}

float IntNum::singlePrecisionfloat()
{
	ofstream fout("cache.bin", ios::out | ios::binary);
	fout.write((char*)& base_10_int, sizeof(unsigned int));
	fout.close();

	float base_10_float;
	ifstream fin("cache.bin", ifstream::binary);
	fin.read((char*)& base_10_float, sizeof(float));
	fin.close();

	return base_10_float;
}

int IntNum::saveFile()
{
	cout << "Input file name:\n->";
	string file_name;
	getline(cin, file_name);
	int result = saveFile(file_name);
	return result;
}

int IntNum::saveFile(string file_name)
{
	cout << "N= ";
	int n;
	cin >> n;
	ofstream fout("cache.bin", ios::out | ios::binary | ios::ate);
	fout.write((char*)& base_10_int, n);
	fout.close();

	return 0;
}

IntNum& operator-(IntNum& a, IntNum b)
{
	IntNum temp;
	temp.base_10_int = a.base_10_int - b.base_10_int;
	return temp;
}

istream& operator>>(istream& ist, IntNum a)
{
	ist >> a.base_10_int;
	return ist;
	// TODO: insert return statement here
}
