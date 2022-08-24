//
//  StatsView.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

enum StatsViewStyle {
    case full
    case compact
}

struct StatsView: View {
    
    let historyModel : DrinkHistoryModel
    let style : StatsViewStyle
    
    var body: some View {
        if (style == .full) {
            HStack(alignment: .center) {
                Spacer()
                StatView(title: "LAST_HOUR", value: historyModel.lastHour, limit: historyModel.hourlyLimit, showFullLabel: style == .full)
                Spacer()
                Divider()
                Spacer()
                StatView(title: "TODAY", value: historyModel.lastDay, limit: historyModel.dailyLimit, showFullLabel: style == .full)
                Spacer()
            }
        } else {
            VStack {
                StatView(title: "LAST_HOUR", value: historyModel.lastHour, limit: historyModel.hourlyLimit, showFullLabel: style == .full)
                StatView(title: "TODAY", value: historyModel.lastDay, limit: historyModel.dailyLimit, showFullLabel: style == .full)
            }
            .padding(.horizontal)
        }
    }
}

struct StatView : View {
    
    let title : LocalizedStringKey
    let value : Int
    let limit : Int
    let showFullLabel : Bool
    
    var body : some View {
        if (showFullLabel) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(.caption, design: .rounded))
                    .bold()
                    .foregroundColor(.accentColor)
                if (showFullLabel) {
                    Text("drink-count \(value)", tableName: "Plurals")
                        .font(.system(.title, design: .rounded))
                        .bold()
                } else {
                    Text(value.formatted())
                        .font(.system(.title, design: .rounded))
                        .bold()
                }
                if (value > limit) {
                    Text("ABOVE_LIMIT")
                        .foregroundColor(.red)
                        .font(.system(.caption, design: .rounded))
                } else {
                    Text("")
                        .foregroundColor(.red)
                        .font(.system(.caption, design: .rounded))
                }
            }
        } else {
            HStack(alignment: .lastTextBaseline){
                Text(value.formatted())
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .foregroundColor(value > limit ? .red : .primary)
                    .padding(.horizontal, 2)
                Text(title)
                    .font(.system(.caption2, design: .rounded))
                    .foregroundColor(.gray)
                    .textCase(.lowercase)
                Spacer()
            }
        }
    }
}
