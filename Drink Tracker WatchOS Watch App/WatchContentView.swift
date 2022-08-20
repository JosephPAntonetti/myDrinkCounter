//
//  ContentView.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/9/22.
//

import SwiftUI
import HealthKit

struct WatchContentView: View {
    
    let healthKitStore = HKHealthStore()
    
    @State var drinkCount = 0
    
    @State var showRequiredPermissionDialog = false
    
    var body: some View {
        NavigationView {
                VStack {
                    Spacer()
                    DrinkCounter(drinkCount: $drinkCount)
                    Spacer()
                    LogDrinkButton(onPress: logDrink)
                }
                .alert("This app requires access to HealthKit to function.", isPresented: $showRequiredPermissionDialog, actions: {})

            .task {
                self.healthKitStore.getDrinkCount(onLoad: {count in self.drinkCount = count}, onFail: {self.showRequiredPermissionDialog = true})
            }
            .navigationTitle("Drink Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.purple)
        }
    }
    
    private func logDrink() {
        healthKitStore.recordDrink(onRecord: {
         _ in
        })
    }
}

struct WatchContentView_Previews: PreviewProvider {
    static var previews: some View {
        WatchContentView()
    }
}
