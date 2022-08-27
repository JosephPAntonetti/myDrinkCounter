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
                VStack(alignment:.leading) {
                    DrinkCountLabel(label: "LAST_HOUR", current: historyModel.lastHour, limit: historyModel.hourlyLimit)
                        .font(.system(size: 28, design: .rounded))
                    DrinkCountLabel(label: "TODAY", current: historyModel.lastDay, limit: historyModel.dailyLimit)
                        .font(.system(size: 28, design: .rounded))
                    ActionButton(label: "LOG_DRINK_BUTTON_LABEL", style: .primary, onPress: {onLogDrink(1)})
                    Divider()
                        .padding(.vertical)
                    NavigationLink("SETTINGS_TITLE", destination: {
                        Settings()
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Drinks")
        }
    }
}
