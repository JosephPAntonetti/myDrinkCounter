//
//  HKHeathStore.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/9/22.
//

import Foundation
import HealthKit

let NumberOfDrinksSampleType = HKSampleType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)!

extension HKHealthStore {
    
    static let Shared : HKHealthStore = HKHealthStore()
    
    func recordDrink() {
        let drinkQuantity = HKQuantity(unit: HKUnit.count(),
                                       doubleValue: 1.0)
            
        let drinkSample = HKQuantitySample(type: NumberOfDrinksSampleType, quantity: drinkQuantity, start: Date(), end: Date())
        
        HKHealthStore().save(drinkSample) { (success, error) in
        }
    }
    
    func getDrinkCount(onLoad : @escaping ([HKSample]?) -> Void, onFail: @escaping () -> Void) {
        let typesToRead : Set<HKObjectType> = [NumberOfDrinksSampleType]
        
        let typesToWrite : Set<HKSampleType> = [NumberOfDrinksSampleType]
        
        self.requestAuthorization(toShare: typesToWrite, read: typesToRead, completion: { (userWasShownPermissionView, error) in
                if (self.authorizationStatus(for: NumberOfDrinksSampleType) != .sharingAuthorized) {
                    onFail()
                } else {
                    self.observeDrinkCount(onLoad)
                }
        })
    }
    
    func observeDrinkCount(_ onLoad : @escaping ([HKSample]?) -> Void) {
        self.enableBackgroundDelivery(for: NumberOfDrinksSampleType, frequency: .immediate) {_,_ in }
        
        let query = HKObserverQuery(sampleType: NumberOfDrinksSampleType, predicate: nil) {
            query, completionHandler, error in
                if (error == nil) {
                    self.loadDrinkCount(onLoad)
                    completionHandler()
                }
        }
        
        self.execute(query)
    }
    
    
    func loadDrinkCount(_ onLoad : @escaping ([HKSample]?) -> Void) {
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let todaysDrinksPredicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: NumberOfDrinksSampleType, predicate: todaysDrinksPredicate, limit: 999, sortDescriptors: nil, resultsHandler: {
            (_, samples, _) in DispatchQueue.main.async {
                onLoad(samples)
            }
        })

        self.execute(query)
    }
}
