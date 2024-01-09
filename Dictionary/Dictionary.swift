//
//  File.swift
//  Dictionary
//
//  Created by Dmitrii Vilgauk on 09.01.2024.
//

import Foundation
import SwiftData

@Model
class Dictionary {
    var word: String
    var translate: String
    var example: String
    
    init(word: String, translate: String, example: String) {
        self.word = word
        self.translate = translate
        self.example = example
    }
}
