//
//  SearchOptionsView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI

struct SearchCategory: Hashable {
    var searchTerm: String = ""
    var searchSymbol: String = ""
}

struct SearchOptionsView: View {
    
    let searchOptions = ["Dog Parks": "dog.fill", "Restaurants": "fork.knife", "Hotels": "bed.double.fill", "Coffee": "cup.and.saucer.fill", "Gas": "fuelpump.fill", "Historical Sites": "books.vertical.fill"]

    
    let searchCategories = [
        SearchCategory(searchTerm: "DogParks", searchSymbol: "dog.fill"),
        SearchCategory(searchTerm: "Coffee", searchSymbol: "cup.and.saucer.fill"),
        SearchCategory(searchTerm: "Restaurants", searchSymbol: "fork.knife"),
        SearchCategory(searchTerm: "Hotels", searchSymbol: "bed.double.fill"),
        SearchCategory(searchTerm: "Gas", searchSymbol: "fuelpump.fill"),
        SearchCategory(searchTerm: "EV Chargers", searchSymbol: "ev.charger.fill"),
        SearchCategory(searchTerm: "Tesla Chargers", searchSymbol: "ev.charger.fill"),
        SearchCategory(searchTerm: "Historical Sites", searchSymbol: "books.vertical.fill"),
        SearchCategory(searchTerm: "Emergency Room", searchSymbol: "cross.case.fill")
    ]
    
    let onSelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false)  {
            HStack {
 
                ForEach(searchCategories, id: \.self) {category in
                    Button(action: {
                        // action
                        onSelected(category.searchTerm)
                    }, label: {
                        HStack {
                            Image(systemName: category.searchSymbol)
                            Text(category.searchTerm)
                        }
                    })
                    
                }
            }.buttonStyle(.borderedProminent)
                .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
                .foregroundColor(.black)
                .padding(4)
        }
    }
}

#Preview {
    SearchOptionsView(onSelected: { _ in })
}
