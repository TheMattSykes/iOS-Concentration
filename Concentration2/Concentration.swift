//
//  Concentration.swift
//  Concentration2
//
//  Created by Matthew Sykes on 19/06/2019.
//  Copyright © 2019 mattsykes. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]() // Initialise an empty array of Cards
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set { // default set(newValue)
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipCount = 0
    
    var scoreCount = 0
    
    private var emojiThemes = ["Halloween": "🎃👻🕸🕷🧙‍♀️🍭🍬🍎🦇",
                        "Holiday": "🎄🎁🍺❤️🎅🍰🍫🔔🍎",
                        "Animals": "🐶🐱🐰🦊🐵🐴🐍🐢🐟"]
    
    var emojiChoices: String
    
    mutating func newGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards march
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    scoreCount += 2 // add 2 to score if match made
                } else {
                    scoreCount -= 1 // take 1 from score if match failed
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    /*
    Initialiser for Concentration
    */
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            // Create two identical matching cards
            let card = Card()
            cards += [card, card] // append the cards to the cards array
        }

        let key = Array(emojiThemes.keys)[Int.random(in: 0 ..< emojiThemes.count)]
        
        emojiChoices = emojiThemes[key] ?? "????????"
        
        cards.shuffle() // randomise order of cards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
