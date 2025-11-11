/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_1023,ASSIGNMENT_8A
DESCRIPTION:THIS_PROGRAM_LETS_THE_USER_TO_TYPE_IN_A_NUMBER_FROM_2_TO_20,AND_
WON'T_ACCEPT_ANY_INPUT_LESS_THAN_2_OR_GREATER_THAN_20,AND_NOT_INTEGER_INPUT
,LETS_THE_USER_PUT_IN_A_CHARACTER_AND_PRINTS_THE_CHARACTER_IN_DOULBE_TRIANGLES
USING_NESTED_FOR_LOOPS_WITH_THE_SIZE_OF_THE_INTEGER,ONE_TRIANGLE_UPSIDEDOWN_AND_
ONE_RIGHTSIDE_UP
INPUT:INTEGER,CHARACTER
OUTPUT:DOUBLE_TRIANGLE,ONE_UPSIDEDOWN,ONE_RIGHTSIDEUP
*/
#include <iostream>
using namespace std;
// variables MAX and MIN are unchangable, so we delared them as
// global variables
int MAX = 20, MIN = 2;
// this user defined function is used to take the input from the user
// and chekc for any errors from the input variable
int getIntegerInput (string prompt, int MIN, int MAX){
    int number = 0;    
    do {
        cout << prompt;
        cin >> number;
        if (cin.fail() == true || number < MIN || number > MAX){
            cin.clear();
            cin.ignore(100, '\n');
            cout << "\nError: Invalid input!" << endl;
            continue;
        }
    }while(number < MIN || number > MAX);
    return number;
}
// this user defined function is used to take the input from the
// user and use the character in the for loops
char getCharacterInput (string prompt, char character){
    cout << prompt;
    char symbol = ' ';
    cin >> symbol;
    return symbol;
}
// void function is used to print out the characher in a triangle
// form upside down, downgrading it
void writeUpsideDownTriangle (int size, char character){
    for (int i = size; i > 0; i--){
        for (int j = i; j > 0; j--){
                cout << character;
        }
        cout << endl; 
    }
}
// this user defined function is used to print out the the characher
// in a triangle form opposite of the previous function
void writeRightsideUpTriangle (int size, char character){
    for (int i = 1; i < size + 1; i++){
        for (int j = 0; j < i; j++){
            cout << character;
        }
        cout << endl;
    }
}
// execute all the user defined functions in the int main function
int main(){
    int number = 0;
    string header = "Enter a count between 2 and 20 \n**";
    number = getIntegerInput(header, MIN, MAX);
    char symbol = ' ';
    header = "\nEnter a character \n**";
    symbol = getCharacterInput(header, symbol);
    cout << endl;
    writeUpsideDownTriangle(number, symbol);
    writeRightsideUpTriangle(number, symbol);
    return 0;
}