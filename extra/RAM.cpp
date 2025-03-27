class ram {
    public:
        ram();

        long arr[999999] = {0};
        ram* next = nullptr;
};

ram::ram(){}

int main(int argc, const char** argv) {
    ram* tc = new ram();
    ram* tc2 = new ram();
    while (true) {
        tc->next = new ram();
        tc2->next = new ram;
        tc = tc->next;
        tc2 = tc2->next;
    }
}