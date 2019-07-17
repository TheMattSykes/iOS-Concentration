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
        var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        game.newGame()
        return game
    }
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2 // get, read only
    }
    
    // Initialise when in use (lazy), instantiate a new game of concentration
    private lazy var game = requestNewGame()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private let attributes: [NSAttributedString.Key:Any] = [
        .strokeWidth : 5.0,
        .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    ]
    
    @IBOutlet private weak var scoreCountLabel: UILabel! {
        didSet {
            updateScoreCountLabel()
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = requestNewGame()
        updateFlipCountLabel()
        updateScoreCountLabel()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            // Increase flipCount when card is flipped but not when card is faceUp or matched
            let card = game.cards[cardNumber]
            if (!card.isFaceUp && !card.isMatched) {
                game.flipCount += 1
            }
            
            game.chooseCard(at: cardNumber)
            updateFlipCountLabel()
            updateScoreCountLabel()
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateFlipCountLabel() {
        flipCountLabel.attributedText = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
    }
    
    private func updateScoreCountLabel() {
        scoreCountLabel.attributedText = NSAttributedString(string: "Score: \(game.scoreCount)", attributes: attributes)
    }
    
    private func updateViewFromModel() {
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
    }
    
    private var emoji = [Card:String]() // Dictionary with Int,String
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, game.emojiChoices.count > 0 {
            let randomStringIndex = game.emojiChoices.index(game.emojiChoices.startIndex, offsetBy: game.emojiChoices.count.arc4random)
            emoji[card] = String(game.emojiChoices.remove(at: randomStringIndex))
        }
        
        // Return unwrapped if not nil, if nil return ?
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self > 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
