//
//  PreviousDaysView.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

struct PreviousDaysView: View {
    
    let limit : Int
    let days : [PreviousDay]
    
    private let gridItemLayout = [GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50)),  GridItem(.flexible(minimum: 50)),  GridItem(.flexible(minimum: 50))]
    
    var body: some View {
        Section(
            content: {
                LazyVGrid(columns: gridItemLayout, spacing: 25) {
                    ForEach(days) {
                        day in VStack {
                            ZStack {
                                if (day.quantity > limit) {
                                    Circle()
                                        .fill()
                                        .foregroundColor(.red)
                                    Text(day.quantity.formatted())
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(.body, design: .rounded))
                                } else {
                                    Circle()
                                        .stroke()
                                        .foregroundColor(Color.gray)
                                    Text(day.quantity.formatted())
                                        .foregroundColor(.gray)
                                        .bold()
                                        .font(.system(.body, design: .rounded))
                                }
                                    
                            }
                            .frame(height: 50)
                            Text(day.date.formatted(date: .numeric, time: .omitted))
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.vertical)
            },
            header: {
                Text("PREVIOUS_DAYS")
                    .bold()
                    .foregroundColor(.primary)
                    .textCase(.none)
                    .font(.system(.title2, design: .rounded))
            }
        )
    }
}

struct PreviousDaysView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previousDays = (0...10).map { i in
            PreviousDay(date: Calendar.current.date(byAdding: .day, value: i, to: Date())!, quantity: i)
        }
        
        return List {
            PreviousDaysView(limit: 2, days: previousDays)
        }
    }
}
