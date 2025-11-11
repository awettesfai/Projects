/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_1023,ASSIGNMENT_8B
DESCRIPTION:THIS PROGRAM LETS THE USER INPUT A RADIUS AND OUTS THE RADIUS,CIRCUMFERENCE,
AREA OF THE RADIUS
INPUT:TWO INPUT NUMBERS
OUTPUT: THE SUM,DIFFERENCE,MULTIPLICATION,DIVISION
*/
#include <iostream>
#include <iomanip>
// use iomanip to use fixed setprecision to set the numbers to
// two decimal digits
using namespace std;
// this user defined function is used to check for errors
// in the input
bool checkFailure (double input, double min, double max){
        if (cin.fail() == true){
            cin.clear();
            cin.ignore(100, '\n');
            return false;
        }
        if (input < min || input > max){
            return false;
        }
        return true;
}
// this user defined function is used to save the input
double getDoubleInput (string prompt, double min, double max){
    double num = 0;
    do{
        cout << prompt;
        cin >> num;
        if (checkFailure(num, min, max) == false){
            cout << "\nError: Invalid input!" << endl;
        }
    }while(checkFailure(num, min, max) == false);
    return num;
}
// this user double input and update the input
void getDoubleInputs (double& input1, double& input2){
    string header = "Enter double between 0.500000 and 20.500000 \n**";
    string header2 = "Enter another double between 0.500000 and 20.500000 \n**";
    const double min = 0.5, max = 20.5;
    input1 = getDoubleInput(header, min, max);
    cout << endl;
    input2 = getDoubleInput(header2, min, max);
    cout << endl;
}
// this is used to do the addition and subtraction
// for the two input, and save the result to the two numbers
void addSubtract (double& add_1, double& add_2){
    double ini_1 = add_1, ini_2 = add_2;
    add_1 = ini_1 + ini_2;
    cout << fixed << setprecision(2) << ini_1 << " + " << ini_2 << " = " << add_1 << endl;
    add_2 = ini_1 - ini_2;
    cout << ini_1 << " - " << ini_2 << " = " << add_2 << endl;
}
// this is used to do the  and subtraction
// for the two input, and save the result to the two numbers
void multiplyDivide (double& add_1, double& add_2){
    double ini_1 = add_1, ini_2 = add_2;
    add_1 = ini_1 * ini_2;
    cout << fixed << setprecision(2) << ini_1 << " * " << ini_2 << " = " << add_1 << endl;;
    add_2 = ini_1 / ini_2;
    cout << ini_1 << " / " << ini_2 << " = " << add_2;
}
int main(){
    double num_1 = 0;
    double num_2 = 0;
    getDoubleInputs(num_1, num_2);
    // We set the two input to two new variables to save
    // them when doing the multiplication and division 
    // calculation
    double main_num_1 = num_1, main_num_2 = num_2;
    addSubtract(num_1, num_2);
    multiplyDivide(main_num_1, main_num_2);
    return 0;
}