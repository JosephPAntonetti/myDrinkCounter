//
//  WatchHome.swift
//  Drink Tracker WatchOS Watch App
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

struct WatchHome: View {
    
    let historyModel : DrinkHistoryModel
    let onLogDrink: (Int) -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    StatsView(historyModel: historyModel, style: .compact)
                    ActionButton(label: "LOG_DRINK_BUTTON_LABEL", style: .primary, onPress: {onLogDrink(1)})
                }
                Divider()
                    .padding(.vertical)
                NavigationLink("SETTINGS_TITLE", destination: {
                    Settings()
                })
            }
            .padding(.top)
            .padding(.horizontal)
            .navigationTitle("Drinks")
        }
    }
}
