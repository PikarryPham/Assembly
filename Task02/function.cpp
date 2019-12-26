#include "function.h"

const char cache[] = "cache.bin";

string input()
{
	cout << "Input: ";
	string temp;
	getline(cin, temp);
	return temp;
}

void xu_li(string& str)
{
	int viTriDauCham = str.find(".");
	bool koDauCham = (viTriDauCham == string::npos);
	//if is koCoDauCham => ep kieu long long / ep kieu int => cout giong tra sua
		// bitset <N> (base_10_int) << '\n';
	if (koDauCham)
		XuLiNguyen(str);
	else
		XuLiThuc(str);
	//if is coDauCham => ep ve double => luc cout thi ep float
}


void XuLiNguyen(string& str)
{
	int N;
	cout << "Float: ";
	char Result[34];
	ConvertRealToFloat(str, Result);
	long int ResultA = changeIntoBase10(Result, 2);
	cout << hex << ResultA;

	cout << "\nDouble: ";
	char Result2[66];
	ConvertRealToDouble(str, Result2);
	//long long int ResultB = changeIntoBase10(Result2, 2);
	//long long int ResultB = 110000001001111110001100000000000000
	//cout << hex << ResultB;
	cout << "\nN= ";
	cin >> N;
	OnlyForInt(str, N);
}

void XuLiThuc(string& str)
{
	int N;
	cout << "Float: ";
	char Result[34];
	ConvertRealToFloat(str, Result);
	long int ResultA = changeIntoBase10(Result, 2);
	cout << hex << ResultA;

	cout << "\nDouble: ";
	char Result2[66];
	ConvertRealToDouble(str, Result2);
}

void ConvertRealToFloat(string& str, char result[])
{
	float real = stof(str);
	//bit dau
	result[0] = real > 0 ? '0' : '1';
	real *= real > 0 ? 1 : -1;
	//bit mu
	long int Fraction = (long int)real;
	char s1[32];
	fromDeci(s1, 2, Fraction);

	int E1 = 24 - strlen(s1);
	int E = 127 + (23 - E1);// E in 2^E
	fromDeci(s1, 2, E);
	for (int i = 0; i < strlen(s1) || i <= 9; ++i)
		result[1 + i] = s1[i];

	//bit luong
	real *= pow(2, E1);
	Fraction = (long int)real;
	fromDeci(s1, 2, Fraction);
	//xoa s1[0], xoa 1,......
	for (int i = 1; i < strlen(s1) || i < strlen(result); ++i)
		result[8 + i] = s1[i];
	for (int i = strlen(s1); i < strlen(result); ++i)
		result[i] = '0';
	result[32] = '\0';
}
void OnlyForInt(string& str, int N)
{
	long long Int = stoll(str);
	char s1[64];
	long long AbsInt = Int > 0 ? Int : Int * -1;
	fromDeci(s1, 2, AbsInt);
	cout << "\nDau tru luong: ";
	if (Int < 0)
		cout << '1';
	else
		cout << '0';
	if (strlen(s1) < N)
	{
		for (int i = 0; i < N - 1 - strlen(s1); i++)
			cout << '0';
		for (int i = 0; i < strlen(s1); i++)
			cout << s1[i];
	}
	else
	{
		int k = 0;
		//8 bit la 1 byte
		//k la so byte
		while (8 * k < strlen(s1)) {
			//neu nhu ma so bit chua du bang 8*k thi k++ cho den khi lon hon do dai chuoi s1 thi dung
			k++;
		}
		/*Phan con thieu minh lap so 0 vao*/
		for (int i = 0; i < 8 * k - 1 - N; i++) {
			cout << '0';
		}

		for (int i = 0; i < N; i++)
			cout << s1[i];
	}
	
	cout << "\nBu mot is: ";

	if (strlen(s1) < N)
	{
		for (int i = 0; i <= N - 1 - strlen(s1); i++)
			cout << '1';
		for (int i = 0; i < strlen(s1); i++)
		{
			if (s1[i] == '0') s1[i] = '1';
			else if (s1[i] == '1') s1[i] = '0';
			cout << s1[i];
		}
	}
	else {
		for (int i = 0; i < N; i++)
		{
			if (s1[i] == '0') s1[i] = '1';
			else if (s1[i] == '1') s1[i] = '0';
			cout << s1[i];
		}
	}

	
	long long int k = Int;

	std::string binary;
	binary.push_back(*s1);

	for (int i = N - 1; i >=0; i--) {

		binary += bitset<1>(k >> i).to_string();
	}
	cout << "\nBu hai is: " << binary.substr(1) << endl;
	//bo di ki tu dau vi no bi du so 0

	//quá 2019
	long long int quaK = Int + 2019;

	std::string binary1;
	binary1.push_back(*s1);

	for (int i = N - 1; i >= 0; i--) {
		binary1 += bitset<1>(quaK >> i).to_string();
	}

	cout << "\nSo qua K is: " << binary1.substr(1) << endl;
}

void ConvertRealToDouble(string& str, char result[])
{
	char tmp[100];
	double real = stod(str);
	//bit dau
	result[0] = real > 0 ? '0' : '1';
	tmp[0] = real > 0 ? '0' : '1';
	real *= real > 0 ? 1 : -1;
	//bit mu
	long long int Fraction = (long long int)real;
	char s1[64];
	fromDeci(s1, 2, Fraction);

	int E1 = 53 - strlen(s1);
	int E = 1023 + (52 - E1);// E in 2^E
	fromDeci(s1, 2, E);
	for (int i = 0; i < strlen(s1) || i <= 12; ++i)
		tmp[1 + i] = s1[i];

	//bit luong
	real *= pow(2, E1);
	Fraction = (long long int)real;
	fromDeci(s1, 2, Fraction);
	
	//tmp[0] = real > 0 ? '0' : '1';
	tmp[12] = s1[1];
	//xoa s1[0], xoa 1,......
	//
	for (int i = 2; i < strlen(s1) || i < strlen(result); i++)
	{
		tmp[11+i] = s1[i];
	}

	for (int i = strlen(s1); i < strlen(result); i++)
		tmp[i] = '0';
	tmp [65] = '\0';
	result = tmp;
	for (int i = 0; i < 64; ++i)
		cout << result[i];

}

