//
//  File.swift
//  StatsProjectDC
//
//  Created by DIEGO CHAVEZ on 11/19/25.
//

import Foundation

class Tech {
    var techList: [Int]
    
    init() {
        techList = []
    }
    
    func addTech(t: Int){
        techList.append(t)
    }
}
