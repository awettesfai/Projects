/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_1023,ASSIGNMENT_8B
DESCRIPTION:THIS PROGRAM LETS THE USER INPUT A RADIUS AND OUTS THE RADIUS,CIRCUMFERENCE,
AREA OF THE RADIUS
INPUT:RADIUS
OUTPUT:RADIUS,AREA,CIRCUMFERENCE
*/
#include <iostream>
#include <cmath>
#include <iomanip>
using namespace std;
// declare global const variable PI to calculate the area and circumference
const double PI = 3.14159;
// declare a user defined function that checks for any errors with
// input radius
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
// declare a user defined function that allows the user to prompt
// them to enter a radius and check for error using the checkFailure 
// user defined function
double getDoubleInput (string prompt, double min, double max){
    double radius = 0;
    do{
        cout << prompt;
        cin >> radius;
        if (checkFailure(radius, min, max) == false){
            cout << "\nError: Invalid radius!" << endl;
        }
    }while(checkFailure(radius, min, max) == false);
    return radius;
}
// declare a user defined function to calculate the circumference
double circumference (double radius){
    double cir = 2 * PI * radius;
    return cir;
}
// declare a user defined function to calculate the area
double area (double radius){
    double area = PI * pow(radius, 2);
    return area;
}
int main (){
    // declare a double radius to use the user defined function getDoubleInput
    // and declare cir and area1 to use the user defined functions
    // double circumference and double area respectively 
    double radius = 0, cir = 0, area1 = 0;
    double min = 0.5, max = 20.5;
    string header = "Enter a circle radius between 0.500000 and 20.500000 \n**";
    radius = getDoubleInput(header, min, max);
    cout << endl;
    // use fixed setprecision to set the out to two double digits
    cout << fixed << setprecision(2) << "Radius: " << radius << endl;
    cir = circumference(radius);
    cout << "Circumference: " << cir << endl;
    area1 = area(radius);
    cout << "Area: " << area1 << endl;
    return 0;
}