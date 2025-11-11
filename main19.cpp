/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1024,ASSIGNMENT_5
DESCRIPTION:THIS_CODE_READS_IN_THE_FILENAME_AND_CHECK_FOR_VIOLATIONS_IN_THE_FILE,
IT_GETS_THE_VIOLATIONS_AND_SAVES_THEM_SEPERATLY_SET_WITH_THE_DATE_OF_THE_VIOLATIONS
WITH_THE_TIME_AND_LICENSE_PLATE
INPUT:FILENAME
OUTPUT:NEW_FILES_WITH_SET_WITH_THE_DATE_OF_EACH_VIOLATIONS
_SEPARATLY_WITH_THE_TIME_AND_LICENSE_PLATE
*/
#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main(){
    // delcare the const variables for the size of the array
    const int row = 3000;
    const int column = 5;
    string arr[row][column] = {};
    // use ifstream to open the file and ofstream 
    // to save the violations in seperate files
    ifstream ifile;
    ofstream ofile;
    string filename;
    // use this do while loop to check for an error
    // in the filename
    do{
        cout << "Open file: ";
        getline (cin, filename);
        ifile.open(filename);
        if (ifile.is_open() == false){
            ifile.clear();
            ifile.ignore(100, '\n');
            cout << "Could not open " << filename << endl;
        }
    }while(!ifile.is_open());
    // string str is used to get each line from the file to analize and save
    // the data into the array
    string str;
    // date is used to save the date of the violations when opening a new file
    string date;
    // comma is used to find commas in str to separate them and save them in the 
    // array
    int comma = 0;
    // count is used for the two last for loops so that we don't need to check for
    // a blank line or if the file reached the end of the line
    int count = 1;
    int violate = 0;
    // this for loop is used to read the file and save the date into the array.
    for (int i = 0; i < row; i++){
        getline (ifile, str);
        // this if statement is used to check if the file reached the end of the file
        // to end the for loop
        count++;
        for (int j = 0; j < column; j++){
            comma = str.find(',');
            arr[i][j] = str.substr(0, comma);
            str = str.substr(comma + 1);
        }
        if (ifile.eof()){
            break;
        }
    }
    // this for loop is used to find the number of violations, by converting
    // each data at column 3 and 4
    for (int i = 0; i < count + 1; i++){
        if (arr[i][3] == ""){
            break;
        }
        if ((stoi(arr[i][3]) < 5000 && stoi(arr[i][4]) > 45) || (stoi(arr[i][3]) >= 5000 && stoi(arr[i][4]) > 30)){
            violate++;
        }
    }
    cout << violate << " violations logged." << endl;
    // this for loop is used to find the number of violations, by converting
    // each data at column 3 and 4, and opens the violations with their dates in
    // different files.
    for (int i = 0; i < count; i++){
        if (arr[i][3] == ""){
            break;
        }
        if (i == 0){
            date = arr[i][1];
            ofile.open("[" + date + "] Report.txt");
        }
        if(date != arr[i][1]){
            ofile.close();
            date = arr[i][1];
            ofile.open("[" + date + "] Report.txt");
        }
        if ((stoi(arr[i][3]) < 5000 && stoi(arr[i][4]) > 45) || (stoi(arr[i][3]) >= 5000 && stoi(arr[i][4]) > 30)){
            ofile << "[" << arr[i][2] << "] " << arr[i][0] << endl;
        }
    }
    return 0;
}