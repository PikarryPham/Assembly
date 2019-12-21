#include <iostream>
using namespace std;
#include <string.h>
#include <string>
int main() {
	int password;

	cout << "Enter password: ";
	cin >> password;
	if (password == 26102000) {
		cout << "Congratulations!" << endl;
	}
	else {
		cout << "Invalid Enter" << endl;
	}
	system("pause");
	return 0;
}