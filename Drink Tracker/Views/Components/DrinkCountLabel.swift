//
//  DrinkCountLabel.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/27/22.
//

import SwiftUI

struct DrinkCountLabel: View {
    
    let label : LocalizedStringKey
    let current : Int
    let limit : Int
    
    private var overLimitStatus : WarningIcon.Status {
        get {
            return current > limit ? .warning : .ok
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
            HStack(alignment: .firstTextBaseline) {
                WarningIcon(status: overLimitStatus)
                Text("drink-count \(current)", tableName: "Plurals")
                    .bold()
            }
        }
    }
}

struct DrinkCountLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            DrinkCountLabel(label: "LAST_HOUR", current: 2, limit: 5)
            DrinkCountLabel(label: "TODAY", current: 2, limit : 1)
        }
    }
}
