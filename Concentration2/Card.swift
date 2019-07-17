//
//  Card.swift
//  Concentration2
//
//  Created by Matthew Sykes on 19/06/2019.
//  Copyright © 2019 mattsykes. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    // func hash solution from surferbrah84 YouTube
    func hash(into hasher: inout Hasher) { hasher.combine(identifier) }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
