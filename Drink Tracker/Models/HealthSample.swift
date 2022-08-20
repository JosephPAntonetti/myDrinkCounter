//
//  HealthSample.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/20/22.
//

import Foundation
import HealthKit

struct HealthSample : Identifiable {
    var id = UUID()
    var date : Date
    
    static func fromHealthKit(healthKitSample: HKSample) -> HealthSample {
        return HealthSample(date: healthKitSample.startDate)
    }
    
    static func fromHealthKit(samples: [HKSample]?) -> [HealthSample] {
        return samples?.map({sample in HealthSample.fromHealthKit(healthKitSample: sample)}) ?? []
    }
}
