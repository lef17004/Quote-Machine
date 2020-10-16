//
//  Quote.swift
//  Quote_Machine
//
//  Created by Michael Le Fevre on 10/14/20.
//

import Foundation

class Quotes {
    let defaults = UserDefaults(suiteName: "group.com.quotemachinegroup")!
    var quoteArray: [String]
    
    init() {
        if let quotes = defaults.array(forKey: "QuoteList") as? [String] {
            quoteArray = quotes
        }
        else {
            defaults.setValue(["If we do not act, we are acted upon.\n -Geogre Orwell"], forKey: "QuoteList")
            quoteArray = ["If we do not act, we are acted upon.\n -Geogre Orwell"]
        }
    }
    
    
    func save(newQuoteArray: [String]) {
        defaults.setValue(newQuoteArray, forKey: "QuoteList")
    }
    
    
    
}
