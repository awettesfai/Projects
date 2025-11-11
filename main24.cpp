#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
using namespace std;
int main(){
    int row = 10, column = 10;
    vector<vector<char>> puzzle;
    ifstream ifile;
    string filename;
     cout<<endl
    <<"     Welcome to\n\n"
    <<"         W \n"
    <<"     C R O S S\n"
    <<"         R\n"
    <<"         D\n\n";
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
    cout << endl;
    for (int i = 0; i < row; i++){
        getline (ifile, str);
        vector<char> row_1;
        for (int j = 0; j < str.length(); j++){
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
    for (int i = 0; i < puzzle.size(); i++){
        for (int j = 0; j < puzzle[i].size(); j++){
            if (puzzle[i][j] != '#'){
                cout << "_" << " ";
            }
            else{
                cout << puzzle[i][j] << " ";
            }
        }
        cout << endl;
    }
    int errors = 5;
    char save_error = 0;
    int count = 0;
    char guess;
    int data = -1;
    vector<char> answers = {};





    
    while(errors != 0){
    count = 0;
    cout << "Enter a letter: \n";
    cin >> guess;
    for (int i = 0; i < puzzle.size(); i++){
        for (int j = 0; j < puzzle[i].size(); j++){
            if (guess - 32 == puzzle[i][j] || guess == puzzle[i][j]){
                count++;
            }
        }
    }
    if (count == 0){
        if (errors == 5){
            save_error = guess;  
        }
        errors--;
        if (errors <= 3){
           if (save_error == guess){
            cout << "The letter is already guessed, try again!" << endl;
        }
        else{
           cout << "The letter is not on the board" << endl; 
        }  
        }else
        {
            cout << "The letter is not on the board" << endl; 
        }
        cout << "Remaining incorrect guesses: " << errors << endl;
        for (int i = 0; i < puzzle.size(); i++){
                for (int j = 0; j < puzzle[i].size(); j++){
                    data = 0;
                    while(data < answers.size()){
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
            while(data == 0){
                answers.push_back(guess);
                data++;
                cout << "Remaining incorrect guesses: " << errors << endl;
        for (int i = 0; i < puzzle.size(); i++){
            for (int j = 0; j < puzzle[i].size(); j++){
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
                if (find(answers.begin(), answers.end(), guess) != answers.end()){
                cout << "The letter is already guessed, try again!" << endl;
                cout << "Remaining incorrect guesses: " << errors << endl;
                for (int i = 0; i < puzzle.size(); i++){
                    for (int j = 0; j < puzzle[i].size(); j++){
                        while(data < puzzle.size()){
                            if(answers[data] - 32 == puzzle[i][j] || answers[data] == puzzle[i][j]){
                                cout << puzzle[i][j] << " ";
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
            for (int i = 0; i < puzzle.size(); i++){
                for (int j = 0; j < puzzle[i].size(); j++){
                    data = 0;
                    while(data < answers.size()){
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
        }
    }
    }

   