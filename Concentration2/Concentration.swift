//
//  Concentration.swift
//  Concentration2
//
//  Created by Matthew Sykes on 19/06/2019.
//  Copyright © 2019 mattsykes. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]() // Initialise an empty array of Cards
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    var scoreCount = 0
    
    var emojiThemes = ["Halloween": ["🎃","👻","🕸","🕷","🧙‍♀️","🍭","🍬","🍎","🦇"],
                        "Holiday": ["🎄","🎁","🍺","❤️","🎅","🍰","🍫","🔔","🍎"],
                        "Animals": ["🐶","🐱","🐰","🦊","🐵","🐴","🐍","🐢","🐟"]]
    
    var emojiChoices: [String]
    
    func newGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards march
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    scoreCount += 2 // add 2 to score if match made
                } else {
                    scoreCount -= 1 // take 1 from score if match failed
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    /*
    Initialiser for Concentration
    */
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            // Create two identical matching cards
            let card = Card()
            cards += [card, card] // append the cards to the cards array
        }

        let key = Array(emojiThemes.keys)[Int.random(in: 0 ..< emojiThemes.count)]
        
        emojiChoices = emojiThemes[key] ?? ["?","?","?","?","?","?","?","?"]
        
        cards.shuffle() // randomise order of cards
    }
}
