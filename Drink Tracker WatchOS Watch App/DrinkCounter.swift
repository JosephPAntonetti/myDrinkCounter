//
//  DrinkCounter.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/10/22.
//

import SwiftUI

struct DrinkCounter: View {
    
    @Binding var drinkCount : Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(String(drinkCount))
            #if os(watchOS)
                .font(.system(size: 70, design: .rounded))
            #else
                .font(.system(size: 120, design: .rounded))
            #endif
                .bold()
            #if os(iOS)
                Text(drinkCount == 1 ? "drink today" : "drinks today")
                .font(.system(size: 18, design: .rounded))
            #endif
        }
    }
}

struct DrinkCounter_Previews: PreviewProvider {
    static var previews: some View {
        DrinkCounter(drinkCount: .constant(0))
    }
}
