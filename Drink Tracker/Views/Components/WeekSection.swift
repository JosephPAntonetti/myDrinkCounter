//
//  WeekSection.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/27/22.
//

import SwiftUI

struct WeekSection: View {
    
    let dailyLimit : Int
    let entries : [Entry]
    
    var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()
    
    private var exceededCount : Int {
            return entries.filter({$0.count > dailyLimit}).count
    }
    
    private var circles : [CircleListView.Entry] {
        get {
            return entries.map({CircleListView.Entry(label: dateFormatter.string(from: $0.date), value: $0.count, filled: $0.count > dailyLimit)})
        }
    }
    
    var body: some View {
        Section("THIS_WEEK"){
            VStack(alignment: .leading) {
                Text("You have exceeded your limit \(exceededCount) times this week.")
                    .font(.system(.body, design: .rounded))
                    .bold()
                Divider()
                CircleListView(fillColor: .red, entries: circles)
                    .frame(height: 65)
            }
        }
    }
    
    struct Entry {
        let date : Date
        let count : Int
    }
}

struct WeekSection_Previews: PreviewProvider {
    static var previews: some View {
        let entries = [
            WeekSection.Entry(date: Date(), count: 1),
            WeekSection.Entry(date: Date(), count: 2),
            WeekSection.Entry(date: Date(), count: 5),
            WeekSection.Entry(date: Date(), count: 1),
            WeekSection.Entry(date: Date(), count: 0),
            WeekSection.Entry(date: Date(), count: 0),
            WeekSection.Entry(date: Date(), count: 0),
        ]
        
        return List {
            WeekSection(dailyLimit: 1, entries: entries)
        }
    }
}
