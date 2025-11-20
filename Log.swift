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
    var date: Date
    var instrument: String
    var amtPractice: Int
    var pieceName: String
    var techs: Int
    
    init(day: Int, month: String, date: Date, instrument: String, amtPractice: Int, pieceName: String, techs: Int) {
        self.day = day
        self.month = month
        self.date = date
        self.instrument = instrument
        self.amtPractice = amtPractice
        self.pieceName = pieceName
        self.techs = techs
    }
    init(day: Int, month: String, instrument: String, amtPractice: Int, pieceName: String) {
        self.day = day
        self.month = month
        date = Date()
        self.instrument = instrument
        self.amtPractice = amtPractice
        self.pieceName = pieceName
        techs = 0
    }
}
