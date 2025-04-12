//
//  Item.swift
//  SwiftUI-Intro
//
//  Created by Aran Davies on 12/04/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
