#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
using namespace std;
int main(){
    int row = 10, column = 0;
    int i = 0, j = 0;
    bool error = false;
    bool over = false;
    vector<vector<char>> puzzle;
    ifstream ifile;
    string filename;
     cout<<endl
    <<"     Welcome to\n\n"
    <<"         W \n"
    <<"     C R O S S\n"
    <<"         R\n"
    <<"         D\n\n";
while(over != true)
{
do{
        cout << "Enter level to play: \n";
        cin >> filename;
        ifile.open(filename);
        if (ifile.is_open() == false){
            cin.clear();
            cin.ignore(100, '\n');
            cout << "Invalid Entry!" << endl;
        }
    }while(ifile.is_open() == false);
    string str;
    int strr = 0;
    cout << endl;
    for (i = 0; i < row; i++){
        getline (ifile, str);
        vector<char> row_1;
        strr = str.length();
        for (j = 0; j < strr; j++){
            if (str[j] == ' '){
                continue;
            }
            else
            {
            row_1.push_back(str[j]);
            }
        }
        puzzle.push_back(row_1);
        if (ifile.eof()){
            break;
        }
    }
    int repeat = 0;
    row = puzzle.size();
    column = puzzle[i].size();
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
    int count = 0;
    int size_answer = 0;
    int errors = 5;
    char save_error = 0;
    char guess;
    int data = -1;
    vector<char> answers(25);
    vector<char> realAnswers = {};
    int check = 0;
    char response = ' ';
    // game loop
    while(repeat != check || error != 0){
    if (repeat == check){
            cout << "Congradulations, you won!" << endl;
            cout << "Would you like to play again? " << endl;
            cin >> response;
            switch (response){
            case 'Y':
            case 'y':
            over = true;
            break;
            case 'n':
            case 'N':
            cout << "Thank you for playing CrossWord!" << endl;
            return 0;
            default:
            cout << "Invalid entry!" << endl;
            break;
        }
        }
    if (errors == 0){
        cout << "Better luck next time!" << endl;
        cout << "Would you like to play again? " << endl;
        cin >> response;
        switch (response){
            case 'Y':
            case 'y':
            over = true;
            break;
            case 'n':
            case 'N':
            cout << "Thank you for playing CrossWord!" << endl;
            return 0;
            default:
            cout << "Invalid entry!" << endl;
            break;
        }
    }
    size_answer = answers.size();
    count = 0;
    cout << "Enter a letter: \n";
    cin >> guess;
    for (i = 0; i < row; i++){
        for (j = 0; j < column; j++){
            if (guess - 32 == puzzle[i][j] || guess == puzzle[i][j]){
                count++;
            }
        }
    }
    if (count == 0){
       if(find(answers.begin(), answers.end(), guess) != answers.end()){
                cout << "The letter is already guessed, try again!" << endl;
                cout << "Remaining incorrect guesses: " << errors << endl;
                for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
                            break;
                        }
                        else{
                            data++;
                        }
                    }
                    if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
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
            errors--;
            cout << "Letter not on board" << endl;
            cout << "Remaining incorrect guesses: " << errors << endl;
            answers.push_back(guess);
            for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
                            break;
                        }
                        else{
                            data++;
                        }
                    }
                    if (guess - 32 == puzzle[i][j] || guess == puzzle[i][j]){
                        check++;
                    }
                    if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
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
            if(data == 0){
                answers.push_back(guess);
                data++;
                cout << "Remaining incorrect guesses: " << errors << endl;
            for (i = 0; i < row; i++){
                    for (j = 0; j < column; j++){
                    if (guess - 32 == puzzle[i][j] || guess == puzzle[i][j] ){
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
            if(find(answers.begin(), answers.end(), guess) != answers.end()){
                cout << "The letter is already guessed, try again!" << endl;
                cout << "Remaining incorrect guesses: " << errors << endl;
                for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
                            break;
                        }
                        else{
                            data++;
                        }
                    }
                    if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
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
            cout << "Remaining incorrect guesses: " << errors << endl;
            answers.push_back(guess);
            for (i = 0; i < row; i++){
                for (j = 0; j < column; j++){
                    data = 0;
                    while(data < size_answer){
                        if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
                            break;
                        }
                        else{
                            data++;
                        }
                    }
                    if (guess - 32 == puzzle[i][j] || guess == puzzle[i][j]){
                        check++;
                    }
                    if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
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

   