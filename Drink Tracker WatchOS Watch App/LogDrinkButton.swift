//
//  LogDrinkButton.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/10/22.
//

import SwiftUI
import HealthKit

struct LogDrinkButton: View {
    
    let onPress : () -> Void
    
    var body: some View {
        Button( action: {
            #if os(iOS)
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                impactHeavy.impactOccurred()
            #endif
            onPress()
        }) {
            Text("Log Drink")
                .bold()
                .font(.system(.body, design: .rounded))
            #if os(iOS)
                .padding(.horizontal)
            #endif
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.purple)
        #if os(iOS)
            .controlSize(.large)
        #endif
        .padding()
    }
}

struct LogDrinkButton_Previews: PreviewProvider {
    static var previews: some View {
        LogDrinkButton {}
    }
}
