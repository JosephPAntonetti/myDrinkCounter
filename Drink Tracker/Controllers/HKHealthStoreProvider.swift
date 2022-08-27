//
//  HKHealthStoreProvider.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI
import HealthKit

let NumberOfDrinksSampleType = HKSampleType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)!

struct HKHealthStoreProvider<Content>: View where Content : View{
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var toggle = false
    
    private let store = HKHealthStore()
    
    @State private var samples : [HKSample] = []
    @State private var showPermissionDialog = false
    
    @ViewBuilder let content : ([HKSample], @escaping (Int) -> Void) -> Content
    
    var body: some View {
        content(samples, addDrinkSample)
            .alert("PERMISSION_NOT_GRANTED_ERROR", isPresented: $showPermissionDialog, actions: {})
            .task(id: toggle) {
                requestAuthorization()
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    toggle.toggle()
                }
            }
    }
    
    private func addDrinkSample(quantity: Int) {
        let drinkQuantity = HKQuantity(unit: HKUnit.count(), doubleValue: Double(quantity))
        
        let drinkSample = HKQuantitySample(type: NumberOfDrinksSampleType, quantity: drinkQuantity, start: Date(), end: Date())
        
        store.save(drinkSample) {(_, _) in }
    }
    
    private func requestAuthorization() {
        
        let typesToRead : Set<HKObjectType> = [NumberOfDrinksSampleType]
        let typesToWrite : Set<HKSampleType> = [NumberOfDrinksSampleType]
        
        store.requestAuthorization(toShare: typesToWrite, read: typesToRead, completion: { (userWasShownPermissionView, error) in
            if (store.authorizationStatus(for: NumberOfDrinksSampleType) != .sharingAuthorized) {
                showPermissionDialog = true
            } else {
                self.enableObservation()
            }
        })
    }
    
    private func enableObservation() {
        store.enableBackgroundDelivery(for: NumberOfDrinksSampleType, frequency: .immediate) {_,_ in }
        
        let query = HKObserverQuery(sampleType: NumberOfDrinksSampleType, predicate: nil) {
            query, completionHandler, error in
            if (error == nil) {
                self.updateSamples()
                completionHandler()
            }
        }
        
        store.execute(query)
    }
    
    
    private func updateSamples() {
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: -20, to: now, wrappingComponents: false)
        
        let todaysDrinksPredicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: NumberOfDrinksSampleType, predicate: todaysDrinksPredicate, limit: 999, sortDescriptors: nil, resultsHandler: {
            (_, samples, _) in DispatchQueue.main.async {
                self.samples = samples ?? []
            }
        })
        
        store.execute(query)
    }
}
