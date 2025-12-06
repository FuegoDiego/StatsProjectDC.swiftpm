//
//  SwiftUIView.swift
//  StatsProjectDC
//
//  Created by DIEGO CHAVEZ on 12/5/25.
//

import SwiftUI
import Charts
import SwiftData
struct ChartView: View {
    @Query(sort: \Log.date, order: .forward) var qLogs: [Log]
    var body: some View {
        
        Text("\(qLogs.count)")
        Chart(qLogs){log in
            BarMark(x: .value("Day", log.date), y: .value("Score out of 10", log.techs))
        }
        Text("\(averageTech())")
    }
    func averageTech()-> Double{
        var total = 0.0
        for log in qLogs{
            total += Double(log.techs)
        }
        return total/Double(qLogs.count)
    }
}
#Preview {
    ChartView()
}

