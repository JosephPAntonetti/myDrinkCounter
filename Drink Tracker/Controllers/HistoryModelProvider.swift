//
//  HistoryModelProvider.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI
import HealthKit

struct HistoryModelProvider<Content>: View where Content : View {
    
    let samples : [HKSample]
    @ViewBuilder let content : (DrinkHistoryModel) -> Content
    
    @AppStorage(Constants.HOUR_LIMIT_PREFERENCE) var hourlyLimit : Int = 2
    @AppStorage(Constants.DAY_LIMIT_PREFERENCE) var dailyLimit : Int = 5
    
    var lastHourCount : Int {
        get {
            let oneHourAgo = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
            
            return countDrinks(samples.filter({$0.startDate >= oneHourAgo}))
        }
    }
    
    var lastDayCount : Int {
        get {
            let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            
            return countDrinks(samples.filter({$0.startDate >= oneDayAgo}))
        }
    }
    
    var previousDays : [PreviousDay] {
        get {
            let dict = Dictionary(grouping: samples, by: { Calendar.current.startOfDay(for: $0.startDate) })
            
            return (0..<7)
                .map({Calendar.current.date(byAdding: .day, value: -1 * $0, to: Calendar.current.startOfDay(for: Date()))!})
                .map({PreviousDay(date: $0, quantity: countDrinks(dict[$0] ?? []))})
        }
    }
    
    var model : DrinkHistoryModel {
        get {
            DrinkHistoryModel(lastHour: lastHourCount, lastDay: lastDayCount, hourlyLimit: hourlyLimit, dailyLimit: dailyLimit, previousDays: previousDays)
        }
    }
    
    var body: some View {
        content(model)
    }
    
    private func countDrinks(_ samples: [HKSample]) -> Int {
        return samples.reduce(0, {curr, sample in Int((sample as! HKQuantitySample).quantity.doubleValue(for: .count())) + curr })
    }
    
}
