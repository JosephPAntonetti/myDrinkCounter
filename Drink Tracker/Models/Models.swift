//
//  Models.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import Foundation

struct DrinkHistoryModel {
    
    let lastHour : Int
    let lastDay : Int
    
    let hourlyLimit : Int
    let dailyLimit : Int
    
    let previousDays : [PreviousDay]
    
}

struct PreviousDay : Identifiable {
    let id = UUID()
    
    let date : Date
    let quantity : Int
}
