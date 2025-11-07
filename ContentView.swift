import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selectedDay = 1
    @State var selectedMonth = "January"
    @State var selectedInstrument = "Gutair"
    @State var selectedAmtTime = 5
    @State var logList: [Log] = []
    @Query var qLogs: [Log]
    @Environment(\.modelContext) var context
    var body: some View {
        VStack {
            Text("Instrument Practice Logs")
            List{
                Text("Placeholder")
                ForEach(qLogs){ item in
                    
                }
            }
           
        }
            
        NavigationView {
            NavigationLink("Add a Log"){
                PracticeView(selectedDay: $selectedDay, selectedMonth: $selectedMonth, logList: $logList))
            }
        }
    }
}
