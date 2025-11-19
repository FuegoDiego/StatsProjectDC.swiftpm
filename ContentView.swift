import SwiftData
import SwiftUI

struct ContentView: View {
    @State var selectedDay = 1
    @State var selectedMonth = "January"
    @State var logList: [Log] = []
    @State var selectedInstrument = "Guitar"
    @State var selectedAmtTime = 15.0
   
    @State var selectedPiece = ""
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
                        selectedAmtTime: $selectedAmtTime,
                        selectedPiece: $selectedPiece
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
    func calculateStreaks(){
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
    }
    /* func calculateStreaks(){
        // Initializing streaks for a single log case
        if qLogs.count == 1 {
            weeklyStreak = 1
            dailyStreak = 1
             // Added return for early exit
        }
        
        // Logic for multiple logs
        if qLogs.count > 1 {
            for i in 0..<qLogs.count - 1 {
                let log1 = qLogs[i]
                let log2 = qLogs[i+1]
                
                var dayDifference: Int
                
                if log1.month == log2.month {
                    // Case 1: Same month
                    dayDifference = log2.day - log1.day
                } else if checkMonths(log1: log1, log2: log2)true {
                    // Case 2: Different months (using helper function)
                    // Note: The logic below is what was causing the most trouble.
                    // We assume chckMonth returns the number of days to add for month wrap
                    let daysToAdjust = chckMonth(log: log2)
                    dayDifference = (log2.day + daysToAdjust) - log1.day
                } else {
                    // If months are different but checkMonths is false, skip or handle
                    continue
                }
                
                // Check for Weekly Streak (between 7 and 14 days)
                if dayDifference >= 7 && dayDifference <= 14 {
                    weeklyStreak += 1
                }
                
                // Check for Daily Streak (exactly 1 day)
                if dayDifference == 1 {
                    dailyStreak += 1
                }
            }
        }
    }
    /**/*/func checkMonths(log1: Log, log2: Log)-> Bool{
        var allMonths: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        var x: Int = 0
        var y: Int = 0
        
        for i in 0..<allMonths.count{
            if(log1.month == allMonths[i]){
                x = i
            }
            if(log2.month == allMonths[i]){
                y = i
            }
            
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
