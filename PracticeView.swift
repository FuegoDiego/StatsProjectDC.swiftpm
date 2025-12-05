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
    @Binding var selectedDate: Date
    @State var days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
    @State var allMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @State var instruments = ["Guitar", "Violin", "Flute", "Clarinet", "Saxophone", "Trumpet", "French Horn", "Trombone", "Drum Set", "Piano"]
    @State var amtOfTimes = [15, 30, 45, 60, 90, 120, 150, 180]
    @State var a = 0.0
    @State var logCheck = false
    @Query var qLogs: [Log]
    @Environment(\.modelContext) var context
    @Binding var logList: [Log]
    @Binding var selectedInstrument: String
    @Binding var selectedAmtTime: Double
    @Binding var selectedPiece: String
    @Binding var selectedTech: Double
    
    //Gemini
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Please enter date")
                .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
                .bold()
            VStack{
                
                /*Picker("Select Day", selection: $selectedDay){
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
                .bold()*/
                
                ZStack{
                    Capsule()
                        .fill(.white)
                        .frame(width: 200, height:30)
                        
                    DatePicker("", selection: $selectedDate)
                        .labelsHidden()
                        .accentColor(.white)
                        .datePickerStyle(.compact)
                }
                
                
            
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
            
            Slider(value: $selectedAmtTime, in: 15...180, step: 15){
        
            }
            Text("\(selectedAmtTime, specifier: "%.0f") minutes")
                .foregroundStyle(.white)
                .bold()
            Text("Enter the name of the piece practiced")
                .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
                .bold()
            
            TextField("Enter the name of the piece practiced", text: $selectedPiece)
                .foregroundStyle(.white)
                .bold()
                .multilineTextAlignment(.center)
                .overlay(){
                    Capsule()
                        .stroke(.white)
                        .frame(width: 300, height: 30)
                }
            
            Slider(value: $selectedTech, in: 1...10)
            Text("\(selectedTech, specifier: "%.0f")")
                .foregroundStyle(.white)
                .bold()
            /*Picker("Select Amount Time", selection: $selectedAmtTime){
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
            }*/
            
            Spacer()
                .frame(width: 1, height: 30)
            
            Button("Add Log"){
                let temp = Log(day: selectedDay, month: selectedMonth, date: selectedDate, instrument: selectedInstrument, amtPractice: Int(selectedAmtTime.rounded()), pieceName: selectedPiece, techs: Int(selectedTech))
                //if checkLog(l: temp){
                    logList.append(temp)
                    context.insert(temp)
                    try? context.save()
                    /*print(Int(selectedAmtTime))
                    print(selectedAmtTime)
                    print(selectedAmtTime.rounded())*/
                    dismiss()
                //}else{
                    //logCheck = true
                //}
                
            }
            .foregroundStyle(Color(red: 212/255, green: 175/255, blue: 55/255))
            .bold()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .alert("Date already exists", isPresented: $logCheck){
            
        }
    }
    func checkLog(l: Log)-> Bool{
        for log in qLogs{
            if(l.month == log.month && l.day == l.day){
                return false
            }
        }
        return true
    }
}

#Preview {
    PracticeView(selectedDay: .constant(1), selectedMonth: .constant("January"), selectedDate: .constant(Date()), logList: .constant([Log(day: 1, month: "January", instrument: "French Horn", amtPractice: 15, pieceName: "")]), selectedInstrument: .constant("French Horn"), selectedAmtTime: .constant(5), selectedPiece: .constant(""), selectedTech: .constant(0.0))
}
