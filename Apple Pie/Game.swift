//
//  Game.swift
//  Apple Pie
//
//  Created by Wafiq Syed on 2019-07-27.
//  Copyright © 2019 Wafiq Syed. All rights reserved.
//  This program creates a Game strcuture
//  Each round begins with a selection of a new word, and resetting
//  the number of moves a player can make to incorrectMovesAllowed

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
    
    // Create computed prooperty called formattedWord
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
}
