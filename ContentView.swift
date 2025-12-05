import SwiftData
import SwiftUI

struct ContentView: View {
    @State var selectedDay = 1
    @State var selectedMonth = "January"
    @State var selectedDate = Date()
    @State var logList: [Log] = []
    @State var selectedInstrument = "Guitar"
    @State var selectedAmtTime = 15.0
    @State var selectedPiece = ""
    @Query(sort: \Log.date, order: .forward) var qLogs: [Log]
    @State var selectedTech = 0.0
    @State var weeklyStreak = 0
    @State var dailyStreak = 0
    
    @Environment(\.modelContext) var context
    var body: some View {
        //Gold: Color(red: 212/255, green: 175/255, blue: 55/255)
        NavigationView {
            VStack {
                Text("Instrument Practice Logs")
                    .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                    .bold()
                    .font(.title)
                List {
                    //Text("Placeholder")
                    ForEach(qLogs) { log in
                        
                        VStack(alignment: .leading) {
                            Text("\(log.date.formatted(.dateTime.month().day()))")
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                .font(.title2)
                            Text("-------------")
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                .font(.title2)
                            Text("Piece: " + log.pieceName)
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                .font(.title3)
                            Text("Practiced on \(log.instrument)")
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                            
                            if Double(log.amtPractice) / 60.0 == 1.0 {
                                Text(
                                    "Practiced for \(log.amtPractice/60) hour"
                                )
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                
                            } else if log.amtPractice > 60 && log.amtPractice % 60 == 0{
                                
                                Text(
                                    "Practiced for \(log.amtPractice/60) hours"
                                )
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                
                            } else if Double(log.amtPractice) / 60.0 > 1.0 {
                                Text(
                                    "Practiced for \((Double(log.amtPractice)/60.0), specifier: "%.2f") hours"
                                )
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                
                            }else{
                                Text("Practiced for \(Int(log.amtPractice)) minutes")
                                    .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                    .bold()
                            }
                            
                            if qLogs.count == 0{
                                Text("No logs")
                            }
                            
                        }
                        .listRowBackground(Color.black)
                        
                    }
                    .onDelete(perform: deleteLog)
                    
                    

                }
                .scrollContentBackground(.hidden)
                .background(Color(red: 64/255, green: 64/255, blue: 64/255))
                
                Spacer()
                    .frame(width: 10, height: 20)
                
                ZStack {
                    
                    NavigationLink("Add a Log +") {
                        PracticeView(
                            selectedDay: $selectedDay,
                            selectedMonth: $selectedMonth,
                            selectedDate: $selectedDate,
                            logList: $logList,
                            selectedInstrument: $selectedInstrument,
                            selectedAmtTime: $selectedAmtTime,
                            selectedPiece: $selectedPiece,
                            selectedTech: $selectedTech
                        )
                    }
                    .foregroundColor(.white)
                    .bold()
                    .overlay(){
                        Capsule()
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 140, height: 60)
                    }
                }
                
                Spacer()
                    .frame(width: 10, height: 20)
                
                /*Text("Weekly streak of \(weeklyStreak)")
                    .foregroundColor(.white)
                    .bold()*/
                if dailyStreak >= 5 && dailyStreak < 15{
                    Text("Daily streak of \(dailyStreak) 🔥")
                        .foregroundColor(.white)
                        .bold()
                }else if dailyStreak >= 15{
                    Text("Daily streak of \(dailyStreak) 🔥🔥🔥")
                        .foregroundColor(.white)
                        .bold()
                }else{
                    Text("Daily streak of \(dailyStreak)")
                        .foregroundColor(.white)
                        .bold()
                }
                
                if qLogs.count > 0{
                    Text("Techichal skills out of 10: \(averageTech(), specifier: "%.1f")")
                        .foregroundColor(.white)
                        .bold()
                }
                
                Button{
                    for log in qLogs {
                        context.delete(log)
                    }
                    try? context.save()
                } label: {
                    ZStack {
                        Capsule()
                            .fill(.red)
                            .frame(width: 100, height: 20)
                            
                        Text("Delete All")
                            .foregroundStyle(.white)
                            .bold()
                        
                            
                    }
                }
                
            }
            .background(Color.black)
            .onAppear(){
                calculateStreaks()
                print("\(dailyStreak)")
                print("\(weeklyStreak)")
                print("\(qLogs.count)")
            }
        }
        .onAppear(){
            calculateStreaks()
            print("\(dailyStreak)")
            print("\(weeklyStreak)")
            print("\(qLogs.count)")
        }
        
    }
    func deleteLog(at offsets: IndexSet) {
        for index in offsets {
            let thing = qLogs[index]
            context.delete(thing)
            try? context.save()
        }
    }
    /*func calculateStreaks(){
        if qLogs.count == 1{
            weeklyStreak = 1
            dailyStreak = 1
        }
        if qLogs.count > 1{
            for i in 0..<qLogs.count-1{
                if qLogs[i].month == qLogs[i+1].month{
                    if qLogs[i+1].day - qLogs[i].day >= 7 && qLogs[i+1].day - qLogs[i].day <= 14{
                        weeklyStreak += 1
                    }
                    if qLogs[i+1].day - qLogs[i].day == 1{
                        dailyStreak += 1
                    }
                }
                if checkMonths(log1: qLogs[i], log2: qLogs[i+1]){
                    if (qLogs[i+1].day + chckMonth(log: qLogs[i+1])) - qLogs[i].day >= 7 && (qLogs[i+1].day + chckMonth(log: qLogs[i+1])) - qLogs[i].day <= 14{
                        weeklyStreak += 1
                    }
                    if (qLogs[i+1].day + chckMonth(log: qLogs[i+1])) - qLogs[i].day == 1{
                        dailyStreak += 1
                    }
                }
            }
        }
    }*/
     func calculateStreaks(){
         dailyStreak = 1
         weeklyStreak = 1
        for i in qLogs.indices.dropLast(){
            //ChatGPT
            let calendar = Calendar.current
            let day = calendar.component(.day, from: qLogs[i].date)
            let month = calendar.component(.month, from: qLogs[i].date)
            let year = calendar.component(.year, from: qLogs[i].date)
            //
            
            let day2 = calendar.component(.day, from: qLogs[i+1].date)
            let month2 = calendar.component(.month, from: qLogs[i+1].date)
            let year2 = calendar.component(.year, from: qLogs[i+1].date)
            
            let ogDate: Date = qLogs[0].date
            
            if year == year2{
                
                if month == month2{
                    if day2 - day == 1{
                        dailyStreak += 1
                    }else{
                        dailyStreak = 1
                    }
                    if day2 - day <= 14 && day2 - day >= 7{
                        weeklyStreak += 1
                    }else if day2 - day >= 14{
                        weeklyStreak = 1
                    }
                }else{
                    if (day2 + checkMonths(mont: month)) - day == 1{
                        dailyStreak += 1
                    }else{
                        dailyStreak = 1
                    }
                    if (day2 + checkMonths(mont: month)) - day <= 14 && (day2 + checkMonths(mont: month)) - day >= 7{
                        weeklyStreak += 1
                    }else if (day2 + checkMonths(mont: month)) - day >= 14{
                        weeklyStreak = 1
                    }
                }
            }else{
                if(month == 12 && month2 == 1){
                    if (day2 + 31) - day == 1{
                        dailyStreak += 1
                    }else{
                        dailyStreak = 1
                    }
                    if (day2 + 31) - day <= 14 && (day2 + 31) - day >= 7{
                        weeklyStreak += 1
                    }else if (day2 + 31) - day >= 14 {
                        weeklyStreak = 1
                    }
                }
            }
            
        }
        
         if(qLogs.count == 1){
             dailyStreak = 1
             weeklyStreak = 1
             print("New Streak")
         }
         if(qLogs.count == 0){
             dailyStreak = 0
             weeklyStreak = 0
             print("No Streak")
         }
    }
    func checkMonths(mont: Int)-> Int{
        if mont == 1 || mont == 3 || mont == 5 || mont == 7 || mont == 8 || mont == 10 || mont == 12{
            return 31
        }else if mont == 4 || mont == 6 || mont == 9 || mont == 11{
            return 30
        }else{
            return 28
        }
    }
    func averageTech()-> Double{
        var total = 0.0
        for log in qLogs{
            total += Double(log.techs)
        }
        return total/Double(qLogs.count)
    }
}
