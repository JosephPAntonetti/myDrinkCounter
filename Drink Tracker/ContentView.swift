//
//  ContentView.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/9/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    let formatter = RelativeDateTimeFormatter()
    
    @State var recentDrinks : [HealthSample] = []
    
    @State var showRequiredPermissionDialog = false
    
    @State var showingSettings = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        DrinkCount(drinkCount: self.recentDrinks.count)
                        LogDrinkButton()
                    }
                    .padding(.vertical)
                }
                ListSection(title: "RECENT_ACTIVITY") {
                    if ((recentDrinks.count == 0)){
                        HStack{
                            Spacer()
                            Text("NO_RECENT_ACTIVITY")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.vertical)
                    } else {
                        ForEach(self.recentDrinks.sorted(by: {x, y in x.date > y.date})) {
                            drink in HStack {
                                Text("SAMPLE_LABEL")
                                Spacer()
                                Text(formatter.localizedString(for: drink.date, relativeTo: Date.now))
                                    .font(.caption)
                            }
                            .foregroundColor(.gray)
                        }
                    }
                    Button("OPEN_HEALTH_ACTION",
                           action: {
                        UIApplication.shared.openURL(URL(string:"x-apple-health://")!)
                    })
                    
                }
            }
            .alert("This app requires access to HealthKit to function.", isPresented: $showRequiredPermissionDialog, actions: {})
            .task {
                formatter.unitsStyle = .full
                HKHealthStore.Shared.getDrinkCount(onLoad: {samples in self.recentDrinks = HealthSample.fromHealthKit(samples: samples)}, onFail: {self.showRequiredPermissionDialog = true})
            }
            .navigationTitle("APP_NAME")
            .toolbar {
                Button(action: {
                    showingSettings.toggle()
                }, label: {
                    Label("", systemImage: "gear")
                })
            }
            .sheet(isPresented: $showingSettings, content: {
                Settings()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
