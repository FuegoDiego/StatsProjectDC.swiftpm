import SwiftData
import SwiftUI

struct ContentView: View {
    @State var selectedDay = 1
    @State var selectedMonth = "January"
    @State var selectedInstrument = "Guitar"
    @State var selectedAmtTime = 15.0
    @State var logList: [Log] = []
    @Query var qLogs: [Log]
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
}
