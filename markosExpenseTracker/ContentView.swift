//
//  ContentView.swift
//  markosExpenseTracker
//
//  Created by Marko Poikkimäki on 2023-11-23.
//

import SwiftUI
import SwiftData


struct SecondView: View {
    let name: String
    @State private var user = User()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Second View").bold()
            Text("Hello \(name)!")
            
            Divider()
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Dismiss") {
                dismiss()
            }
        }
        Spacer()
    }
}

struct ThirdView: View {
    @Environment(\.dismiss) var dismiss
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
                Button("Dismiss") {
                    dismiss()
                }
            }.toolbar {
                EditButton()
            }
            Spacer()
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingSheet = false
    @State private var showList = false
    

    var body: some View {
        VStack {
            Text("Yo man!").bold()
            Divider()
            Button("Show sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet, content: {
                SecondView(name: "Marko")
            })
            Button("Show list") {
                showList.toggle()
            }
            .sheet(isPresented: $showList, content: {
                ThirdView()
            })
        }
        Spacer()
    }

  
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
