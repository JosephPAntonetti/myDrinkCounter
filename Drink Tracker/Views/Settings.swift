//
//  Settings.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage(Constants.HOUR_LIMIT_PREFERENCE) var hourlyLimit : Int = 2
    @AppStorage(Constants.DAY_LIMIT_PREFERENCE) var dailyLimit : Int = 5
    
    var body: some View {
        List {
            Section("HOURLY_LIMIT") {
                HStack {
                    Text("drink-count \(hourlyLimit)", tableName: "Plurals")
                        .textCase(.none)
                    Spacer()
                    Stepper("", value: $hourlyLimit)
                }
            }
            Section("DAILY_LIMIT") {
                HStack {
                    Text("drink-count \(dailyLimit)", tableName: "Plurals")
                        .textCase(.none)
                    Spacer()
                    Stepper("", value: $dailyLimit)
                }
            }
        }
        .navigationTitle("SETTINGS_TITLE")
    }
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
