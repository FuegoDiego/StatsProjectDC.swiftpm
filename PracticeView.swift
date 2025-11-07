//
//  SwiftUIView.swift
//  StatsProjectDC
//
//  Created by DIEGO CHAVEZ on 11/6/25.
//


import SwiftUI
import SwiftData

struct PracticeView: View {
    @Binding var selectedDay: Int
    @Binding var selectedMonth: String
    @State var days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
    @State var allMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @State var instruments = ["Guitar", "Violin", "Flute", "Clarinet", "Saxophone", "Trumpet", "French Horn", "Trombone", "Drum Set", "Piano"]
    @Binding var logList: [Log]
    @Binding var selectedInstrument: String
    @Binding var selectedAmtTime: Int
    //Gemini
    @Environment(\.dismiss) var dismiss
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
                    ForEach(allMonths, id: \.self){ item in
                        Text(item)
                            .tag(item)
                    }
                }
                Button("Add Log"){
                    
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    PracticeView(selectedDay: .constant(1), selectedMonth: .constant("January"), logList: .constant([Log(day: 1, month: "January", instrument: "French Horn", amtPractice: 5)]), selectedInstrument: .constant("French Horn"), selectedAmtTime: .constant(5))
}
