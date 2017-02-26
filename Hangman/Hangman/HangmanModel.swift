//
//  HangmanModel.swift
//  Hangman
//
//  Created by Jimmy on 2/25/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation
class HangmanModel{
    var currentWord : String;
    var answer: String
    var slotFilled = 0
    var wrongLetter = ""
    var numWrong = 0
    var numSpace = 0
    
    init(word: String){
        currentWord = ""
        for (letter) in word.characters {
            if(String(letter)==" "){
                numSpace += 1
                currentWord += " "
            }else{
                currentWord += "_"
            }
        }
        //currentWord = String(repeating: "_", count: word.characters.count)
        answer = word
    }
    
    func getLength() -> Int{
        return answer.characters.count;
    }
    
    func getCurrentDisplayWord() -> String{
        var display = ""
        for (letter) in currentWord.characters{
            display += String(letter)
            display += " "
        }
        return display
    }
    func tryLetter(letter: String) -> Bool{
        var currentList = Array(currentWord.characters)
        var answerList = Array(answer.characters)
        var i = 0
        var right = false
        while(i<currentList.count){
            let currentLetter = currentList[i]
            let rightLetter = answerList[i]
            
            if(currentLetter==" "){
                i = i+1
                continue;
            }
            if(currentLetter == "_"){
                if(letter == String(rightLetter)){
                    right = true
                    slotFilled += 1
                    currentList[i] = Character(letter)
                }
            }
            i = i+1
            
        }
        currentWord = String(currentList)
        if(!right){
            addIncorrect(letter: letter)
            numWrong += 1
            return false
        }
        return true
        
        
    }
    
    func addIncorrect(letter: String){
        wrongLetter += " "
        wrongLetter += letter
    }
    
    func getIncorrectString() -> String{
        return wrongLetter
    }
    
    func checkWin() -> Bool{
        return slotFilled == getLength()-numSpace
    }
    
    func checkLost() ->Bool{
        return numWrong == 6
    }
    
    func getImgName() -> String{
        let name1 = "hangman"
        let num = String(numWrong+1)
        return name1+num
    }
    
    
    
}
