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
    
    @State var showAbout = false
    
    var body: some View {
        NavigationView {
            List {
                OverviewSection(entries: [
                    OverviewSection.Entry(label: "LAST_HOUR", current: historyModel.lastHour, limit: historyModel.hourlyLimit),
                    OverviewSection.Entry(label: "TODAY", current: historyModel.lastDay, limit: historyModel.dailyLimit)
                ], onAddDrink: onLogDrink)
                WeekSection(dailyLimit: historyModel.dailyLimit, entries: historyModel.previousDays.map({WeekSection.Entry(date: $0.date, count: $0.quantity)}))
                Section("Your Limits") {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hourly Limit")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.accentColor)
                            Text("\(historyModel.hourlyLimit) drinks")
                                .bold()
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Daily Limit")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.accentColor)
                            Text("\(historyModel.dailyLimit) drinks")
                                .bold()
                                .font(.body)
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                    NavigationLink("Edit Limits", destination: Settings())
                        .foregroundColor(.accentColor)
                }
                Section {
                    Button("OPEN_HEALTH_ACTION",
                           action: {
                        UIApplication.shared.openURL(URL(string:"x-apple-health://")!)
                    })
                }
            }
            .navigationTitle("DRINK_SCREEN_TITLE")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Log Drink") {
                        onLogDrink(1)
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button("ABOUT_SECTION") {
                            showAbout = true
                        }
                    }, label: { Label("", systemImage: "ellipsis.circle")})
                }
            }
            .sheet(isPresented: $showAbout) {
                About()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let previousDays = (0..<7).map { i in
            PreviousDay(date: Calendar.current.date(byAdding: .day, value: i, to: Date())!, quantity: i)
        }
        
        let dummy = DrinkHistoryModel(lastHour: 2, lastDay: 4, hourlyLimit: 100, dailyLimit: 2, previousDays: previousDays)
        
        return Home(historyModel: dummy, onLogDrink: {_ in })
    }
}
