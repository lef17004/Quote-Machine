//
//  ContentView.swift
//  QuoteMachine
//
//  Created by Michael Le Fevre on 10/6/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var action: Int? = 0
    
    @State var quoteList = Quotes().quoteArray
    
    
    
    
    
    
    
    
    var body: some View {
        NavigationView {
            
               
            VStack {
                NavigationLink(destination: NewQuoteView(quoteList: $quoteList), tag: 1, selection: $action) {
                    EmptyView()
                }
                
                
                
                List {
                    ForEach(quoteList, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: removeQuote)
                }
                    
            }
            .navigationBarTitle("Your Quotes")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Add"){self.action = 1})
        }
            
        
    }
    
    func removeQuote(at offsets: IndexSet) {
        for index in offsets {
            quoteList.remove(at: index)
            Quotes().save(newQuoteArray: quoteList)
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
