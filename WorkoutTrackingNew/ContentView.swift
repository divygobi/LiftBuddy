//
//  ContentView.swift
//  Devote
//
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    //mark - property
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var task: String = ""
    @State var sets: String = ""
    @State var reps: String = ""
    @State var weight: String = ""
    @State var dates = [Date]()
    @State private var selectedTab = 0
    
    
    private var isButtonDisabled: Bool {
        task.isEmpty || sets.isEmpty || reps.isEmpty || weight.isEmpty
    }
    // FETCHING DATA
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            dates.append(Date())
            newItem.timestamp = Date()
            newItem.task = task
            newItem.reps = reps
            newItem.sets = sets
            newItem.weight = weight
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    //Create Tab
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack{
                    VStack(spacing: 16){
                        Group{
                            TextField("New Workout", text: $task)
                                .padding(10)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            HStack{
                                TextField("Reps", text: $reps)
                                    .padding(10)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(10)
                                    .keyboardType(UIKeyboardType.decimalPad)
                                TextField("Sets", text: $sets)
                                    .padding(10)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(10)
                                    .keyboardType(UIKeyboardType.decimalPad)
                            }
                            TextField("Weight", text: $weight)
                                .padding(10)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .keyboardType(UIKeyboardType.decimalPad)
                        }
                        .font(Font.system(size: 14, design: .default))
                        
                        
                        Button(action: {addItem()}, label: {
                            Spacer()
                            Text("Add Workout")
                            Spacer()
                        })
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(isButtonDisabled ? Color.gray:Color.pink)
                        .cornerRadius(10)
                        .disabled(isButtonDisabled)
                    } //:VSTACK
                    .padding()
                    List {
                        ForEach(items.reversed()) { item in
                            VStack(alignment: .leading) {
                                HStack(){
                                    Text(item.task ?? "" )
                                    Text(item.reps ?? "" )
                                    Text("x")
                                    Text(item.sets ?? "" )
                                    Text("at")
                                    Text(item.weight ?? "")
                                    Text("lbs")
                                }
                                
                                Text("Workout at \(item.timestamp!, formatter: itemFormatter) ")
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                                //List Item
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }//:List
                    
                }//:VStack
                .navigationBarTitle("Add Workout", displayMode: .large)
                .toolbar {
                    #if os(iOS)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    #endif
                    
                    
                    
                }//: TOOLBAR
            }//: NAVIGATION
            .tabItem {
                Image(systemName: "plus")
                Text("Add Workout")
            }
            .tag(0)
            
            CalendarView(dates: dates)
                .tabItem {
                    Image(systemName: "calendar.badge.clock")
                    Text("History")
                }
                .tag(1)
            Text("Settings")
                .tabItem{
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(2)
        }
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
