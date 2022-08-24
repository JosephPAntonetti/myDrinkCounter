//
//  HomeController.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

struct HomeController: View {
    var body: some View {
        HKHealthStoreProvider {
            (samples, onLogDrink) in
            HistoryModelProvider(samples: samples) {
                historyModel in
#if os(iOS)
                Home(historyModel: historyModel, onLogDrink: onLogDrink)
#else
                WatchHome(historyModel: historyModel, onLogDrink: onLogDrink)
#endif
            }
        }
    }
}
