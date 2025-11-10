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
    @State var amtOfTimes = [15, 30, 45, 60, 90, 120, 150, 180]
    @Environment(\.modelContext) var context
    @Binding var logList: [Log]
    @Binding var selectedInstrument: String
    @Binding var selectedAmtTime: Int
    //Gemini
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Please enter date")
                .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
                .bold()
            HStack{
                Picker("Select Day", selection: $selectedDay){
                    ForEach(days, id: \.self){ i in
                        Text("\(days[i-1])")
                            .tag(i)
                            
                    }
                }
                .accentColor(.white)
                .bold()
                
                Picker("Select Month", selection: $selectedMonth){
                    ForEach(allMonths, id: \.self){ item in
                        Text(item)
                            .tag(item)
                            
                    }
                }
                .accentColor(.white)
                .bold()
            }
            Text("Select instrument")
                .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
                .bold()
            Picker("Select Instrument", selection: $selectedInstrument){
                ForEach(instruments, id: \.self){ item in
                    Text(item)
                        .tag(item)
                }
                
            }
            .accentColor(.white)
            .bold()
            Text("Select the amount of time practiced")
                .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
                .bold()
        
            Picker("Select Amount Time", selection: $selectedAmtTime){
                ForEach(amtOfTimes, id: \.self){ i in
                    if(i%60 == 0){
                        Text("\(i/60) hours")
                            .tag(i)
                    }else if(Double(i)/60 > 1){
                        Text("\(Double(i)/60, specifier: "%.1f") hours")
                            .tag(i)
                    }else{
                        Text("\(i) minutes")
                            .tag(i)
                    }
                }
            }
            
            Spacer()
                .frame(width: 1, height: 30)
            
            Button("Add Log"){
                logList.append(Log(day: selectedDay, month: selectedMonth, instrument: selectedInstrument, amtPractice: selectedAmtTime))
                context.insert(Log(day: selectedDay, month: selectedMonth, instrument: selectedInstrument, amtPractice: selectedAmtTime))
                try? context.save()
                dismiss()
            }
            .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
            .bold()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

#Preview {
    PracticeView(selectedDay: .constant(1), selectedMonth: .constant("January"), logList: .constant([Log(day: 1, month: "January", instrument: "French Horn", amtPractice: 15)]), selectedInstrument: .constant("French Horn"), selectedAmtTime: .constant(5))
}
