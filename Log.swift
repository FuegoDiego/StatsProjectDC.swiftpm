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
    var pieceName: String
    var techs: Tech
    
    init(day: Int, month: String, instrument: String, amtPractice: Int, pieceName: String) {
        self.day = day
        self.month = month
        self.instrument = instrument
        self.amtPractice = amtPractice
        self.pieceName = pieceName
        techs = Tech()
    }
}
