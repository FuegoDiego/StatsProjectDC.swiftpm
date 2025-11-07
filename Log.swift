//
//  File.swift
//  StatsProjectDC
//
//  Created by DIEGO CHAVEZ on 11/6/25.
//

import Foundation

class log {
    var day: Int
    var month: Int
    var instrument: String
    var amtPractice: Int
    
    init(day: Int, month: Int, instrument: String, amtPractice: Int) {
        self.day = day
        self.month = month
        self.instrument = instrument
        self.amtPractice = amtPractice
    }
}
