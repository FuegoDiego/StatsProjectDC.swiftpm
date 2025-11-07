//
//  File.swift
//  StatsProjectDC
//
//  Created by DIEGO CHAVEZ on 11/6/25.
//

import Foundation
import SwiftData

@Model
class Log {
    var day: Int
    var month: String
    var instrument: String
    var amtPractice: Int
    
    init(day: Int, month: String, instrument: String, amtPractice: Int) {
        self.day = day
        self.month = month
        self.instrument = instrument
        self.amtPractice = amtPractice
    }
}
