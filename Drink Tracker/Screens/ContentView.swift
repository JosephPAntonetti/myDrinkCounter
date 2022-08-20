//
//  ContentView.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/9/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
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
                RecentActivity(samples: recentDrinks)
            }
            .alert("PERMISSION_NOT_GRANTED_ERROR", isPresented: $showRequiredPermissionDialog, actions: {})
            .task {
                HKHealthStore.Shared.getDrinkCount(onLoad: {samples in withAnimation {self.recentDrinks = HealthSample.fromHealthKit(samples: samples)}}, onFail: {self.showRequiredPermissionDialog = true})
            }
            .navigationTitle("APP_NAME")
            #if os(iOS)
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
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
