//
//  LogDrinkButton.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/20/22.
//

import SwiftUI
import HealthKit

struct LogDrinkButton: View {
    
    var body: some View {
        Button(action: {
            HKHealthStore.Shared.recordDrink()})
        {
            Text("LOG_DRINK_BUTTON_LABEL")
                .bold()
                .font(.system(.body, design: .rounded))
                .padding(.horizontal)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .frame(maxWidth: .infinity)
    }
}

struct LogDrinkButton_Previews: PreviewProvider {
    static var previews: some View {
        LogDrinkButton()
    }
}
