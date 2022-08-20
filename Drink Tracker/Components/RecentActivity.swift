//
//  RecentActivity.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/20/22.
//

import SwiftUI

struct RecentActivity: View {
    
    let samples : [HealthSample]
    
    let formatter = RelativeDateTimeFormatter()
    
    var body: some View {
        ListSection(title: "RECENT_ACTIVITY"){
            if ((samples.count == 0)){
                HStack{
                    Spacer()
                    Text("NO_RECENT_ACTIVITY")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.vertical, 60.0)
            } else {
                ForEach(self.samples.sorted(by: {x, y in x.date > y.date})) {
                    drink in HStack {
                        Text("SAMPLE_LABEL")
                        Spacer()
                        Text(formatter.localizedString(for: drink.date, relativeTo: Date.now))
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
            }
            #if os(iOS)
            Button("OPEN_HEALTH_ACTION",
                   action: {
                UIApplication.shared.openURL(URL(string:"x-apple-health://")!)
            })
            #endif
        }
        .task {
            formatter.unitsStyle = .full
        }
    }
}

struct RecentActivity_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RecentActivity(samples: [])
            RecentActivity(samples: [
                HealthSample(date: Date()),
                HealthSample(date: Date())
            ])
        }
    }
}
