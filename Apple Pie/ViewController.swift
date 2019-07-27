//
//  ViewController.swift
//  Apple Pie
//
//  Created by Wafiq Syed on 2019-07-27.
//  Copyright © 2019 Wafiq Syed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var words = [
        "basektball", "soccer", "football", "volleyball", "baseball",
        "cricket", "dodgeball", "tennis", "rugby", "hockey"
    ]
    let incorrectMovesAllowed = 5
    
    var currentGame: Game! // Exclamation mark because there's a brief moment when the currentGame variable will be nil (from app launch to first round
    var wins = 0 {
        didSet {
            newRound()
        }
    }
    var losses = 0 {
        didSet{
            newRound()
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]! //Creates an outlet for al                                           letters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    
    func newRound(){
        // Creates a new round by taking a word from the list and initiating a game using the Game struct
        if !words.isEmpty{
            let newWord = words.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(wins), Losses: \(losses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Disables the button after being clicked so that
        // a player can't select a letter more than once
        // in the same round
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            losses += 1
        } else if currentGame.word == currentGame.formattedWord {
            wins += 1
        } else {
            updateUI()
        }
    }
    
}

