/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_TO_1023,ASSIGNMENT_LAB7B
DESCRIPTION:THIS_CODE_READS_THE_DATA_FROM_A_FILE_INTO_A_2D_
ARRAY_AND_READS_THE_CITY_NAME_AND_YEAR_FROM_THE_FILE_AND_
OUTPUT_THE_HIGH,LOW,AVERAGE_HIGH,AVERAGHE_LOW_OF_THE_FILE
INPUT:FILENAME
OUTPUT:THE_NAME_OF_THE_CITY_AND_YEAR_THE_HIGH,
LOW,AVERAGE_HIGH,AVERAGHE_LOW_OF_THE_FILE
*/
#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;
int main(){
    // declare the variables and intitalize the array size
    const int row = 13, column = 2;
    double temp [row][column];
    string city_Name[1][column];
    ifstream ifile;
    string filename;
    // use the do while to allow the user to read the file
    // and check for errors in the filename
    do{
    cout << "Enter file name \n**";
    getline(cin, filename);
    ifile.open(filename);
    if (ifile.is_open() == false) {
    cout << "\nError: Invalid file name\n";
    }
    }while(!ifile.is_open());
    cout << endl;
    // this for loop is used to read the first line of the file
    // which is the name and year of the city, and outputs it
    for (int i = 0; i < 1; i++){
        for (int j = 0; j < column; j++){
            ifile >> city_Name[i][j];
            cout << city_Name[i][j] << " ";
        }
        cout << endl;
    }
    // this for loop reads the file in the form of float variables
    // and use those to find the temperature
    for (int i = 0; i < row; i++){
        for (int j = 0; j < column; j++){
            ifile >> temp[i][j];
        }
    }
    // declare 
    double high = 0;
    double low = 0;
    double average_High = 0;
    double average_Low = 0;
    // this for loop is used to find the lowest and highest tempreture
    // in the file and find the sum of the low tempratures on column 0 and 
    // highest tempreature on column 1, and find the sum of seperatly to calulate
    // the average of the both
    for (int j = 0; j < column; j++){
        for (int i = 0; i < row; i++){
            if (i == 12){
                break;
            }
            if ( j == 0){
            if ( i == 0){
                low = temp[i][j];
            }
            if ( temp[i][j] < low){
                low = temp[i][j];
            }
            average_Low = average_Low + temp[i][j];
            }
            else{
                if (i == 0){
                    high = temp[i][j];
                }
                if ( temp[i][j] > high){
                    high = temp[i][j];
                }
                average_High = average_High + temp[i][j];
            }
        }
    }
    // use fixed setprecision to out the results with two decimal points
    cout << fixed << setprecision(2) << 
    "Lowest temperature of the year was " << low << "° F."  << endl;
    cout << "Highest temperature of the year was " << high << "° F." << endl;
    cout << "Average low temperature of the year was " << average_Low / 12  << "° F." << endl;
    cout << "Average high temperature of the year was " << average_High / 12  << "° F." << endl;
    return 0;
}