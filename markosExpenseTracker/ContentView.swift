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

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingSheet = false
    

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
        }
        Spacer()
    }

  
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
