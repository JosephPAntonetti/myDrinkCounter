//
//  DrinkCount.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/20/22.
//

import SwiftUI

struct DrinkCount: View {
    
    let drinkCount : Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TODAY")
                .font(.system(.subheadline, design: .rounded))
                .bold()
                .foregroundColor(.accentColor)
            Text("drink-count \(drinkCount)", tableName: "Plurals")
                .bold()
                .font(.system(size: 24, design: .rounded))
        }
    }
}

struct DrinkCount_Previews: PreviewProvider {
    static var previews: some View {
        DrinkCount(drinkCount: 1)
    }
}
