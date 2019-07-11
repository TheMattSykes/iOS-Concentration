//
//  ViewController.swift
//  Concentration2
//
//  Created by Matthew Sykes on 12/06/2019.
//  Copyright © 2019 mattsykes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /**
     Calls Concentration initialiser and runs newGame function
     
     - Parameters: None
     - Returns: New game of type Concentration
     */
    func requestNewGame() -> Concentration {
        let game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        game.newGame()
        return game
    }
    
    // Initialise when in use (lazy), instantiate a new game of concentration
    lazy var game = requestNewGame()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = requestNewGame()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            // Increase flipCount when card is flipped but not when card is faceUp or matched
            let card = game.cards[cardNumber]
            if (!card.isFaceUp && !card.isMatched) {
                game.flipCount += 1
            }
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.scoreCount)"
    }
    
    var emoji = [Int:String]() // Dictionary with Int,String
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, game.emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(game.emojiChoices.count)))
            emoji[card.identifier] = game.emojiChoices.remove(at: randomIndex)
        }
        
        // Return unwrapped if not nil, if nil return ?
        return emoji[card.identifier] ?? "?"
    }
}
