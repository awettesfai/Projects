/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_TO_1023,ASSIGNMENT_LAB10B
DESCRIPTION:THIS_PROGRAM_ALLOWS_THE_USER_TO_ENTER_THE_DATA_OF_A
STUDENT_AND_EVALUATE_THE_LETTER_GRADE_OF_THE_STUDENT_BASED_ON_THE
GRADE_DATA_THE_USER_INPUTS
INPUT:NUMBERS,STRINGS
OUTPUT:FIRSTNAME,LASTNAME,GRADE,LETTERGRADE
*/
#include <iostream>
using namespace std;
// use struct to initalize the date to save the studnets data
struct studentType
{
  string first;
  string last;
  int grade;
  char letterGrade;  
};
// getStudnetData is used to get the Data of the studnet
// and save the data in the variables of the struct
void getStudnetData (studentType& student){
    bool error = true;
    cout << "Enter a first name \n**";
    cin >> student.first;
    cout << "\nEnter a last name \n**";
    cin >> student.last;
    cout << endl;
   do{
    error = false;
    cout << "Enter a grade \n**";
    cin >> student.grade;
    if (cin.fail() == true){
        cin.clear();
        cin.ignore(100, '\n');
        cout << "\nError: Invalid grade" << endl;
        error = true;
    }
    if (student.grade < 0 || student.grade > 4){
        cin.clear();
        cin.ignore(100, '\n');
        cout << "\nError: Invalid grade" << endl;
        error = true;
    }
   }while(error == true);
    
}
// getLetterGrade is used to recivie the grade of the student
// and assign a letter grade to the student based on their grade
void getLetterGrade (studentType& student){
    switch(student.grade){
        case 0:
        student.letterGrade = 'F';
        break;
        case 1:
        student.letterGrade = 'D';
        break;
        case 2:
        student.letterGrade = 'C';
        break;
        case 3:
        student.letterGrade = 'B';
        break;
        case 4:
        student.letterGrade = 'A';
        break;
    }
}
// printStudentData is used to recive the data of the student
// and print out the data of the student inputed by the user
// and the resulting letterGrade of the student
void printStudentData (studentType student){
    cout << "\nData Entered" << endl;
    cout << "  student.firstName   = " << student.first << endl;
    cout << "  student.lastName    = " << student.last << endl;
    cout << "  student.grade       = " << student.grade << endl;
    cout << "  student.letterGrade = " << student.letterGrade << endl;
    }
// declare main function to use the about three user function to
// allow the user to input the data of the student
int main(){
    studentType student;
    getStudnetData(student);
    getLetterGrade(student);
    printStudentData(student);
    return 0;
}