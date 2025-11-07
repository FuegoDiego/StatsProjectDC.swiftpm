//
//  SwiftUIView.swift
//  StatsProjectDC
//
//  Created by DIEGO CHAVEZ on 11/6/25.
//

import SwiftUI

struct SwiftUIView: View {
    @State var selectedDay = 1
    @State var selectedMonth = "January"
    @State var days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
    @State var allMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var body: some View {
        VStack{
            Text("Please enter date")
            HStack{
                Picker("Enter Day", selection: $selectedDay){
                    ForEach(0..<days.count, id: \.self){ i in
                        Text("\(days[i])")
                            .tag(i)
                    }
                }
                
                Picker("Enter Month", selection: $selectedMonth){
                    ForEach(0..<allMonths.count, id: \.self){ i in
                        Text(allMonths[i])
                            .tag(i)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
