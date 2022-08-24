//
//  Home.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

struct Home: View {
    
    let historyModel : DrinkHistoryModel
    
    let onLogDrink : (Int) -> Void
    
    @State var showSettings = false
    @State var showAbout = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(alignment: .center) {
                        StatsView(historyModel: historyModel, style: .full)
                    }
                    .padding(.top)
                    HStack(alignment: .center) {
                        Spacer()
                        ActionButton(label: "LOG_DRINK_BUTTON_LABEL", style: .primary, onPress: {
                            onLogDrink(1)
                        })
                        ActionButton(label: "PLUS_TWO", style: .secondary, onPress: {
                            onLogDrink(2)
                        })
                        ActionButton(label: "PLUS_FIVE", style: .secondary, onPress: {
                            onLogDrink(5)
                        })
                        Spacer()
                    }
                    .padding(.vertical)
                }
                PreviousDaysView(limit: historyModel.dailyLimit, days: historyModel.previousDays)
                Section {
                    Button("OPEN_HEALTH_ACTION",
                           action: {
                        UIApplication.shared.openURL(URL(string:"x-apple-health://")!)
                    })
                }
            }
            .navigationTitle("DRINK_SCREEN_TITLE")
            .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Menu(content: {
                         Button("SETTINGS_TITLE") {
                             showSettings = true
                         }
                         Button("ABOUT_SECTION") {
                             showAbout = true
                         }
                     }, label: { Label("", systemImage: "ellipsis.circle")})
                  }
              }
            .sheet(isPresented: $showSettings) {
                Settings()
            }
            .sheet(isPresented: $showAbout) {
                About()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let previousDays = (0...10).map { i in
            PreviousDay(date: Calendar.current.date(byAdding: .day, value: i, to: Date())!, quantity: i)
        }
        
        let dummy = DrinkHistoryModel(lastHour: 2, lastDay: 4, hourlyLimit: 100, dailyLimit: 2, previousDays: previousDays)
        
        return Home(historyModel: dummy, onLogDrink: {_ in })
    }
}
