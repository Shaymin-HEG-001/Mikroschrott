#include <stdlib.h>

using namespace std;

class ram{
    long long num1; long long num2; long long num3;
    long long num4; long long num5; long long num6;
    long long num7; long long num8; long long num9;
    ram* n;
public:
    ram(int, int, int, int, int, int, int, int, int, ram*);
};

int main(){
    ram* r = nullptr;
    while (true){
        r = new ram(1,2,3,4,5,6,7,8,9, r);
    }
    
}

ram::ram(int num1, int num2, int num3, int num4, int num5, int num6, int num7, int num8, int num9, ram* n){
    this->num1 = num1; this->num2 = num2; this->num3 = num3;
    this->num4 = num4; this->num5 = num5; this->num6 = num6;
    this->num7 = num7; this->num8 = num8; this->num9 = num9;
    this->n = n;
}