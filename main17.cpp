/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_TO_1023,ASSIGNMENT_LAB7A
DESCRIPTION:THIS_CODE_READS_THE_DATA_FROM_A_FILE_INTO_A_2D_ARRAY_AND
CHECKS_IF_THERE_ARE_ANY_ERRORS_IN_THE_FILE,OUTPUTS_THE_SUM_OF_EACH_ROW_AND_COLUMN_SEPERATLY
INPUT:FILENAME
OUTPUT:SUM_ROW_WISE_AND_COLUMN_WISE
*/
#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;
int main(){
    // declare the variables and the size of the 2D array
    const int row = 7;
    const int column = 10;
    double arr[row][column];
    ifstream ifile;
    string filename;
    // use do while loop to check for any errors in the file
    do{
    cout << "Enter a file name \n**";
    getline(cin, filename);
    ifile.open(filename);
    if (ifile.is_open() == false) {
    cout << "\nError: Invalid file name\n";
    }
    }while(!ifile.is_open());
    // this for loop is used to read in the data from the file
    // into a 2D array
    for (int i = 0; i < row; i++){
        for (int j = 0; j < column; j++){
            ifile >> arr[i][j];
        }
    }
    // the variable sum is used to initialize the sum of the rows
    // and the columns
    double sum = 0;
    cout << endl;
    // this for loop is used to print out the numbers from the file
    // and find the sum row by row
    cout << "ROW SUMS: " << endl;
    for (int i = 0; i < row; i++){
        for (int j = 0; j < column; j++){
            cout << left << setw(4) << fixed << setprecision(1) << arr[i][j];
            // this if condition is used to remove the "+" at the end of row
            if (j > column - 2){
                cout << "";
            }
            else{
                cout << " + ";
            }
            sum = sum + arr[i][j];
        }
        cout << fixed << setprecision(1) << " = " << sum << endl;
        sum = 0;
    }
    cout << endl;
    // this for loop is used to print out the numbers from the file
    // and find the sum column by column
    cout << "COLUMN SUMS: " << endl;
    for (int j = 0; j < column; j++){
        for (int i = 0; i < row; i++){
            cout << left << setw(4) << fixed << setprecision(1) << arr[i][j];
            // this if condition is used to remove the "+" at the end of the column
            if (i > row - 2){
                cout << "";
            }
            else{
                cout << " + ";
            }
            sum = sum + arr[i][j];
        }
        cout << fixed << setprecision(1) << " = " << sum << endl;
        sum = 0;
    }
    return 0;
}