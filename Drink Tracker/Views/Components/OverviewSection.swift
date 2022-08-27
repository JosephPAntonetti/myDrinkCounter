//
//  OverviewSection.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/27/22.
//

import SwiftUI

struct OverviewSection: View {
    
    let entries : [Entry]
    
    let onAddDrink : (Int) -> Void
    
    var body: some View {
        Section(content: {
            VStack(alignment: .leading, spacing: 10.0) {
                ForEach(entries) {
                    entry in DrinkCountLabel(label: entry.label, current: entry.current, limit: entry.limit)
                }
                    .font(.system(size: 28, design: .rounded))
            }
            
        })
    }
    
    struct Entry : Identifiable {
        
        let id = UUID()
        
        var label : LocalizedStringKey
        var current : Int
        var limit : Int
    }
}

struct OverviewSection_Previews: PreviewProvider {
    static var previews: some View {
        
        let entries = [
            OverviewSection.Entry(label: "LAST_HOUR", current: 2, limit: 5),
            OverviewSection.Entry(label: "TODAY", current: 2, limit: 1)
        ]
        
        List {
            OverviewSection(entries: entries, onAddDrink: {_ in })
        }
    }
}
