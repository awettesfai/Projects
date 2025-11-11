/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_TO_1023,ASSIGNMENT_LAB6B
DESCRIPTION:THIS_CODE_READS_THE_DATA_FROM_A_FILE_INTO_A_2D_ARRAY_AND
CHECKS_IF_THERE_ARE_ANY_ERRORS_IN_THE_FILE,oUTPUTS_THE_FILE_DATE_FORWARDS_AND_BACKWARDS_AND_IF_THERE_
IS_AN_ERROR,THE_CODE_SKIPS_THE_ERROR_AND_DOESN'T_INCLUDE_IT_IN_THE_OUPUT
INPUT:FILENAME
OUTPUT:FILE_DATA
*/
#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
using namespace std;
int main (){
    // declare the variables and const int for the size of the file
    const int SIZE = 100;
    double listNumbers[SIZE] = {};
    string listNames[SIZE] = {};
    ifstream ifile;
    string filename = " ";
    // use do while to check for errors in the file,
    // and repeat if there is an actual error
    do{
    cout << "Enter a file name \n**";
    getline(cin, filename);
    ifile.open(filename);
    if (ifile.is_open() == false) {
    cout << "\nError: Invalid file name.\n";
    }
    }while(!ifile.is_open());
    // the variable string (str) is used to get the string from the file
    // and to read the file to define the name and numbers in the two arrays
    // listNames and listNumbers
    string str;
    int count = 0;
    // spacelocation is used to find the location of a space in the string
    // and the sub-string before the space is the name, and the sub-string after
    // space is the number
    int spaceLocation = 0;
    cout << "\nEnter a name to search \n**";
    string name;
    getline(cin, name);
    while (!ifile.eof()){
        getline(ifile, str);
        if (str == ""){
            break;
        }

        str.find(name);
        spaceLocation = str.find(' ');
        listNames[count] = str.substr(0, spaceLocation);
        str = str.substr(spaceLocation + 1);
        listNumbers[count] = stod(str);
        count++;
    }
cout << endl;
// using for loop, we can output the names and numbers forwards and backwards
cout << "Names Forward: ";
for (int i = 0; i < count; i++){
    cout << listNames[i];
    if (i < count - 1){
        cout << ", ";
    }
    else{
    cout << "";
    }
}
cout << endl;
cout << "Scores Forward: ";
for (int i = 0; i < count; i++){
    cout << listNumbers[i];
    if (i < count - 1){
        cout << ", ";
    }
    else{
    cout << "";
    }
}
cout << endl;
cout << "Names Reverse: ";
for (int i = count - 1; i >= 0; i--){
    cout << listNames[i];
    if (i < count - (count - 1)){
        cout << " ";
    }
    else {
        cout << ", ";
    }
}
cout << endl;
cout << "Scores Reverse: ";
for (int i = count - 1; i >= 0; i--){
    cout << listNumbers[i];
    if (i < count - (count - 1)){
        cout << " ";
    }
    else {
        cout << ", ";
    }
}
cout << endl; 
// result is used to find the search result for the names
// and to save the first iteration of the for loop and 
// that is when result is zero
int result = 0;
// declare sum to find the sum of the numbers with the same 
// array value as the name as the for loop goes
double sum = 0;
// minValue and maxValue is used to find the minimum and 
// maximum of the numbers
double minValue = 0;
double maxValue = 0;
for (int i = 0; i < count; i++){
    // this if statement checks if the name is in the array
    // of listNames, and if its true, then it performes the code
    if (listNames[i] == name){
        // this if statement is used to save the first number when result is zero
        // so that it will return false on the next loop since we are iterating result
        // and we can use the number to find the maximum and minimum
        if (result == 0){
            minValue = listNumbers[i];
            maxValue = listNumbers[i];
        }
        sum = sum + listNumbers[i]; 
        if (listNumbers[i] > maxValue) {
            maxValue = listNumbers[i];
        }
        if (listNumbers[i] < minValue){
            minValue = listNumbers[i];
        } 
        result++;        
    }
}
// since result returns zero when the name is not found
// this if statement checks if result is still zero after the for loop
// if so, then it outputs an error message and ends the program
if (result == 0){
    cout << "Error: " << name << " is not a student in the list" << endl;
    return 0;
}
// out put the Maximum, Minimum, sum, Average
cout << result << " results for " << name << endl;
cout << fixed << setprecision(2)  << "Minimum: " << setw(3) << minValue << endl;
cout << "Maximum: " << setw(3) << maxValue << endl;
cout << "Sum:     " << left << setw(11) << sum << endl;
cout << "Average: " << setw(3) << sum / result << endl;
cout << endl;
return 0;
}