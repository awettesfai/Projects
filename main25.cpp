/*
NAME:AWET_TESFAI,NSHE_ID_2001987166,
COURSE_SECTION_CS_135_1008_1023,ASSIGNMENT_6
DESCRIPTION:THIS IS THE CROSWORD PUZZLE GAME,WHERE THE PLAYER GUESS
THE WORDS IN THE CROSWORD PUZZLE,EACH TIME THE PLAYER GETS A GUESS RIGHT
IT DOESN'T DEDUCT FROM THE AMOUT OF GUESSES,BUT IF HE GETS A LETTER WRONG
THEN IT DEDUCTS FROM THE AMOUNT OF GUESSES,THEN WHEN THE PLAYER 
WINS OR LOSES
THE GAMES STOPS AND ASKS THE USER TO PLAY AGAIN 
OR NOT, IF YES THEN THE GAME WILL RESTART
,IF NO THEN THE PROGRAM WILL END THE GAME
INPUT:CHARACTER
OUTPUT:CROSSWORD PUZZLE RESULT
*/
#include <iostream>
#include <fstream>
// we declare vectors to help us with reading the file name
#include <vector>
// we use algorithm to help us search for an index inside the vector
#include <algorithm>
using namespace std;
int main(){
// row and column are declared to not let 
// the program discover the unsigned
// numbers in the program
    int row = 15, column = 0;
// i and j are used for further varaiable saving in the program
// with the nested for loops
    int i = 0, j = 0;
    bool replay = false;
    vector<vector<char>> puzzle;
    ifstream ifile;
    int filename = 0;
    cout << endl
    <<"     Welcome to\n\n"
    <<"         W \n"
    <<"     C R O S S\n"
    <<"         R\n"
    <<"         D\n\n";
while(true)
{
    bool while_end = true;
    bool first_time = true;
    // we clear puzzle at the beginning of the loop so that
    // we can store the data of the file in an empty vector
    // and set the size of the file to the vector
    puzzle.clear();
    // use do while to check for the input file
    // if the input file is not vaild, it will output an error
    // but if it is valid, it will show the file level
    
    do{
        cout << "Enter level to play: \n";
        cin >> filename;
        if (cin.fail() == true || filename < 1){
            cin.clear();
            cin.ignore(1000, '\n');
            cout << "Invalid Entry!" << endl;
            continue;
        }
        ifile.open("level" + to_string(filename) + ".txt");
        if (ifile.is_open() == false){
            cout << "Level files could not be found!" << endl;
        }
    }while(ifile.is_open() == false);
    // str is used to get the lines of the file
    string str;
    int strr = 0;
    cout << endl;
    // this nested for loop is used to read the file and 
    // save the data of the file into the 2d vector
    for (i = 0; i < row; i++){
        // row_1 is used to save the characters of the file
        // then save those characters in the 2d vector
        vector<char> row_1;
        getline (ifile, str);
        strr = str.length();
        // strr is used to initialize the size of str, and not
        // let the program have errors
        for (j = 0; j < strr; j++){
            if (str[j] == ' '){
                continue;
            }
            if (str[j] != ' ')
            {
            row_1.push_back(str[j]);
            }
        }
        puzzle.push_back(row_1);
        // if the file reaches the end of the line, then it ends
        // the loop and moves on to the next nested for loop
        if (ifile.eof()){
            break;
        }
    }
    // repeat is used to keep track 
    // of the amount of characters
    // repeat is add when ever 
    // the element of the is a letter
    // then it will add up
    int repeat = 0;
    // ro and column are initialized 
    // to the size of the vector, so that
    // the program don't crash.
    row = puzzle.size();
    column = puzzle[i].size();
    // this nested for loop is used to 
    // print out the level in the file
    // accordingly by replacing any 
    // variable that is not '#' with a '_'.
    for (i = 0; i < row; i++){
        for (int j = 0; j < column; j++){
            if (puzzle[i][j] != '#'){
                cout << "_" << " ";
                repeat++;
            }
            else{
                cout << puzzle[i][j] << " ";
            }
        }
        cout << endl;
    }
    // this is where we close the file
    ifile.close();
    // those variables will be further 
    // explained in the next while loop
    int count = 0;
    int size_answer = 0;
    // errors is the amount of guesses the 
    // player has, and decreases when the player
    // guesses wrong
    int errors = 5;
    char guess = ' ';
    int data = -1;
    // vector answer is set to save 
    // the guessed letters and output them
    // whether the players guesses a new letter or is wrong,
    // it will output the answers
    vector<char> answers(25);
    // check is used to keep us with repeat, 
    // so that when check is equal to repeat
    // then the player guessed all the 
    // letters and cleared the level
    int check = 0;
    // response is used to take the answer of 
    // the player, whether he wants to play
    // again or not
    char response = ' ';
    // game loop is used to let 
    // the program evaluate the file
    while(true){
        
    // replay is used to stop the while loop 
    // when the player wins or loses the game
    replay = false;
    while_end = true;
    first_time = true;
    // this if statement is used to check 
    // if the player wins and loses the game
    // then ends the game
    do{
        if (repeat == check  || errors == 0){
        if (repeat == check && first_time == true){
        cout << "\nCongratulations! you solved the level!" << endl;
            }
        if (errors == 0 && first_time == true){
        cout << "\nBetter luck next time!" << endl;
        }
            first_time = false;
            cout << "Play again? (y/n)" << endl;
            cin >> response;
            switch (response){
            case 'Y':
            case 'y':
            while_end = false;
            replay = true;
            break;
            case 'n':
            case 'N':
            while_end = false;
            cout << "Thank you for playing CrossWord!" << endl;
            return 0;
            break;
            default:
            cin.clear();
            cin.ignore(100, '\n');
            cout << "Invalid entry!" << endl;
            break;
        }
        }
        else{
            break;
        }
    }while(while_end == true);
    if (replay == true){
            puzzle.clear();
            break;
        }
    // count is used to see if the letter
    //  the user inputs is true or not
    // by let count add everytime the 
    // user is right, if count doesn't add,
    // then the letter is wrong
    count = 0;
    // size_answer is used to save the 
    // size of answer and using size to
    // output the guessed letters
    size_answer = answers.size();
    cout << "\nEnter a letter: \n";
    cin >> guess;
    // use cin.clear() and cin.ignore() 
    // to clear other letter exept the first
    // letter of the input
    cin.clear();
    cin.ignore(100, '\n');
    for (i = 0; i < row; i++){
        for (j = 0; j < column; j++){
            if (guess - 32 == puzzle[i][j] 
            || guess == puzzle[i][j]){
                count++;
            }
        }
    }
    if (count == 0){
        // this section is executed when count
        // is not greater than 1, which means
        // the letter is not present in the vector
        // if the wrong letter is inputed again, it will
        // tell the user that he input the wrong input
        // again, and if not, it will dicrease the amount of
        // guesses.
if(find(answers.begin(), answers.end(), 
guess) != answers.end()){
cout << "The letter is already guessed, try again!" << endl;
                cout << "Remaining incorrect guesses: " 
                << errors << endl << endl;
                for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] 
                        || answers[data] == puzzle[i][j]){
                            break;
                        }
                        if (answers[data] - 32 != puzzle[i][j] 
                        && answers[data] != puzzle[i][j]){
                            data++;
                        }
                    }
                    if(puzzle[i][j] == answers[data] - 32 
                    || puzzle[i][j] == answers[data]){
                        cout << puzzle[i][j] << " ";
                    }
                    else if (puzzle[i][j] == '#'){
                        cout << puzzle[i][j] << " ";
                    }
                    else{
                        cout << "_ ";
                    }
                }
                cout << endl;
            }
            }
            else{
                // 
            errors--;
            cout << "The Letter is not on the board" << endl;
            cout << "Remaining incorrect guesses: " 
            << errors << endl << endl;
            answers.push_back(guess);
            for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] 
                        || answers[data] == puzzle[i][j]){
                            break;
                        }
                        if(answers[data] - 32 != puzzle[i][j] 
                        && answers[data] != puzzle[i][j]){
                            data++;
                        }
                    }
                    if (guess - 32 == puzzle[i][j] 
                    || guess == puzzle[i][j]){
                        check++;
                    }
                    if(answers[data] - 32 == puzzle[i][j] 
                    || answers[data] == puzzle[i][j]){
                        cout << puzzle[i][j] << " ";
                    }
                    else if (puzzle[i][j] == '#'){
                        cout << puzzle[i][j] << " ";
                    }
                    else{
                        cout << "_ ";
                    }
                }
                cout << endl;
            }
    }
    }
    else{
        // this section checks for when 
        // the input it in the 2d vector
        // and then it will replace the lines with the letter
        // and not decrease the amount of errors
            if(data == 0){
                answers.push_back(guess);
                data++;
                cout << "Remaining incorrect guesses: " 
                << errors << endl << endl;
            for (i = 0; i < row; i++){
                    for (j = 0; j < column; j++){
                    if (guess - 32 == puzzle[i][j] 
                    || guess == puzzle[i][j] ){
                        cout << puzzle[i][j] << " ";
                    }
                    else if (puzzle[i][j] == '#'){
                        cout << puzzle[i][j] << " ";
                    }
                    else{
                        cout << "_ ";
                    }
                }
                cout << endl;
            }
            }
            // this section checks if the letter inputed
            // and outputed before, if is was, then it won't change
            // the lines and the output will be the same as before
            if(find(answers.begin(), answers.end(), guess) 
            != answers.end()){
            cout << "The letter is already guessed, try again!" << endl;
            cout << "Remaining incorrect guesses: " 
                << errors << endl << endl;
                for (i = 0; i < row; i++){
                    for (j = 0; j < column; j++){
                        data = 0;
                        while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] || 
                        answers[data] == puzzle[i][j]){
                            break;
                        }
                        if(answers[data] - 32 != puzzle[i][j] 
                        && answers[data] != puzzle[i][j]){
                            data++;
                        }
                    }
                    if(answers[data] - 32 == puzzle[i][j] || 
                    answers[data] == puzzle[i][j]){
                        cout << puzzle[i][j] << " ";
                    }
                    else if (puzzle[i][j] == '#'){
                        cout << puzzle[i][j] << " ";
                    }
                    else{
                        cout << "_ ";
                    }
                }
                cout << endl;
            }
            }
            else{
            cout << "Remaining incorrect guesses: " 
            << errors << endl << endl;
            answers.push_back(guess);
            for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] ||
                         answers[data] == puzzle[i][j]){
                            break;
                        }
                        if(answers[data] - 32 != puzzle[i][j] 
                        && answers[data] != puzzle[i][j]){
                            data++;
                        }
                    }
                    if (guess - 32 == puzzle[i][j] ||
                     guess == puzzle[i][j]){
                        check++;
                    }
                    if(answers[data] - 32 == puzzle[i][j] ||
                     answers[data] == puzzle[i][j]){
                        cout << puzzle[i][j] << " ";
                    }
                    else if (puzzle[i][j] == '#'){
                        cout << puzzle[i][j] << " ";
                    }
                    else{
                        cout << "_ ";
                    }
                }
                cout << endl;
            }
            }   
        }
    }
}
}   