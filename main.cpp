#include <iostream>
#include <string.h> 
#include <string>
#include <math.h>
#define _MAX_LEN_  pow(10,8)
using namespace std;
/*==========Convert from base 10 to another base=========*/
//
//hàm này được dùng để chuyển số 10 tương ứng thành A, 11 tương ứng thành B, v.v… và nếu đi hết bảng chữ cái nó sẽ quay ngược lại trở về A
char epKieuReverse(int num)
{
	if (num >= 0 && num <= 9)
		return (char)(num + '0');
	else
		return (char)(num - 10 + 'A');
}

// hàm này được dùng để đảo ngược chuỗi
void reverseString(char* str)
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

//hàm convert 1 số từ base 10 sang base khác 
char* fromDeci(char* stringAfter, int base, int inputNum)
{
	int index = 0;

	while (inputNum > 0)
	{
		stringAfter[index++] = epKieuReverse(inputNum % base);
		inputNum /= base;
	}
	stringAfter[index] = '\0';

	// đảo ngược lại chuỗi
	reverseString(stringAfter);
	//trả về chuỗi sau khi đã được return
	return stringAfter;
	//}
}
/*================Convert from another to base 10===========*/
//biến kí tự A tương ứng với số 10, kí tự B tương ứng với số 11, v.v….
int epKieuVal(char c)
{
	if (c >= '0' && c <= '9')
		return (int)(c - '0');
	else
		return (int)(c - 'A' + 10);
	//return (int)(c - 'A');
}
//hàm này dùng để kiểm tra xem chuỗi đó có tồn tại dấu chấm hay không
bool checkPoint(char* str)
{
	for (int i = 0; i < strlen(str); i++) {
		if (str[i] == '.') {
			return true;
		}
	}
	return false;
}
//hàm này dùng để trả ra một số sau khi convert từ base khác tới base 10
double toDeci(char* str, int base)
{
	int len = strlen(str);
	int power = 1.0; // Khởi tạo giá trị ban đầu của pow
	int num = 0.0;  // khởi tạo giá trị ban đầu
	int i;
	int power1 = 1.0;
	double num1 = 0.0;
	// Decimal equivalent is str[len-1]*1 + 
	// str[len-1]*base + str[len-1]*(base^2) + ... 
	if (checkPoint(str)) {
		//nếu tồn tại dấu chấm, ta sẽ xử lý phần sau dấu chấm như sau
		//base - 1 * kí số thứ nhất + base - 2 * kí số thứ hai v.v…
			//hiện tại hàm này chỉ có thể convert một số thực từ hệ bất kì sang hệ 10

			std::string str(str); //hàm  biến đổi char* thành string
		int len = str.find(".");
		int len2 = str.substr(str.find(".") + 1).size();
		string tmp = str.substr(str.find(".") + 1);
		for (int i = len - 1; i >= 0; i--) {
			if (epKieuVal(str[i]) >= base) {
				cout << "Invalid Number" << endl;
				return -1;
			}
			num += epKieuVal(str[i]) * power;
			power = power * base;
		}
		//xử lý phần thập phân của số thực
		for (int k = 0; k < len2; k++) {
			num1 = num1 + epKieuVal(tmp[k]) * pow(base, (k + 1) * (-1));
		}
		double sum = (double)num + (double)num1;
		return sum;
	}
	else {
		for (i = len - 1; i >= 0; i--)
		{
			//ví dụ: nếu ta nhập vào một chuỗi 203 ở base 2 thì nó sẽ báo lỗi
			if (epKieuVal(str[i]) >= base)
			{
				cout << "Khong hop le." << endl;
				return -1;
			}

			num += epKieuVal(str[i]) * power;
			power = power * base;
		}

		return num;
	}
}
//hàm biến đổi một số ở base n sang base m thông qua base 10
//tuy nhiên vẫn chưa thể convert từ một base 100
char* nBaseToMBase(char* str, int base1, int base2) {
	double num1 = toDeci(str, base1);
	return fromDeci(str, base2, num1);
}
int main()
{
	char* str;
	str = new char[_MAX_LEN_];
	cout << "Input number: ";
	cin.getline(str, 100);
	int base1, base2;
	cout << "Input the current base: ";
	cin >> base1;
	cout << "Input the base to convert: ";
	cin >> base2;

	cout << "The equivalent of the real in base " << base1 << " to base " << base2 << " is " << nBaseToMBase(str, base1, base2) << endl;

	system("pause");
	return 0;
}

