import SwiftData
import SwiftUI

struct ContentView: View {
    @State var selectedDay = 1
    @State var selectedMonth = "January"
    @State var selectedInstrument = "Guitar"
    @State var selectedAmtTime = 15.0
    @State var logList: [Log] = []
    @Query var qLogs: [Log]
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
                            Text(log.month + " \(log.day)")
                                .foregroundColor(Color(red: 212/255, green: 175/255, blue: 55/255))
                                .bold()
                                .font(.title3)
                            Text("-------------")
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

                NavigationLink("Add a Log +") {
                    PracticeView(
                        selectedDay: $selectedDay,
                        selectedMonth: $selectedMonth,
                        logList: $logList,
                        selectedInstrument: $selectedInstrument,
                        selectedAmtTime: $selectedAmtTime
                    )
                }
                .foregroundColor(.white)
                .bold()
                
                Text("Weekly streak of \(weeklyStreak)")
                    .foregroundColor(.white)
                    .bold()
                Text("Daily streak of \(dailyStreak)")
                    .foregroundColor(.white)
                    .bold()
            }
            .background(Color.black)
        }
        
    }
    func deleteLog(at offsets: IndexSet) {
        for index in offsets {
            let thing = qLogs[index]
            context.delete(thing)
            try? context.save()
        }
    }
    func calculateStreaks(){
       
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
    }
    func checkMonths(log1: Log, log2: Log)-> Bool{
        let allMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        var x = 0
        var y = 0
        var z = 0
        for month in allMonths{
            if(log1.month == month){
                x = z
            }
            if(log2.month == month){
                y = z
            }
            z += 1
        }
        if(y - x == 1){
            return true
        }else{
            return false
        }
    }
    func chckMonth(log: Log)-> Int{
        let thirtyOneMonths = ["January", "March", "May", "July", "August", "October", "December"]
        let thirtyMonths = ["April", "June", "September", "November"]
        for month in thirtyOneMonths{
            if log.month == month{
                return 31
            }
        }
        for month in thirtyMonths{
            if log.month == month{
                return 31
            }
        }
        return 28
    }
}
