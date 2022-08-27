//
//  CircleListView.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/27/22.
//

import SwiftUI

struct CircleListView: View {
    
    let fillColor : Color
    let entries : [Entry]
    
    var body: some View {
        GeometryReader {
            geometry in
            let actualWidth = geometry.size.width - CGFloat((entries.count - 1) * 6)
            let circleSize = actualWidth / CGFloat(entries.count)
            
            HStack(spacing: 6.0) {
                ForEach(entries) {
                    entry in
                        makeEntry(entry: entry, circleSize: circleSize)
                }
            }
        }
    }
    
    private func makeEntry(entry: Entry, circleSize: CGFloat) -> some View {
        return VStack {
            ZStack {
                if (entry.filled) {
                    Circle()
                        .fill()
                        .foregroundColor(fillColor)
                } else {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2.5))
                        .foregroundColor(Color(UIColor.lightGray))
                 
                }
                Text("\(entry.value)")
                    .bold()
                    .foregroundColor(entry.filled ? .white : Color(UIColor.lightGray))
                    .scaledToFit()
            }
            Text(entry.label)
                .font(.caption)
                .foregroundColor(Color(UIColor.lightGray))
                .bold()
                .scaledToFit()
        }
        .frame(width: circleSize)
    }
    
    struct Entry : Identifiable {
        
        let id = UUID()
        
        let label : String
        let value : Int
        
        let filled : Bool
    }
}

struct CircleListView_Previews: PreviewProvider {
    static var previews: some View {
        let entries = [
            CircleListView.Entry(label: "1", value: 1, filled: true),
            CircleListView.Entry(label: "2", value: 1, filled: false),
            CircleListView.Entry(label: "3", value: 1, filled: true),
            CircleListView.Entry(label: "4", value: 1, filled: false),
            CircleListView.Entry(label: "5", value: 1, filled: false),
            CircleListView.Entry(label: "6", value: 1, filled: false),
            CircleListView.Entry(label: "7", value: 1, filled: false),
        ]
        
        VStack {
            CircleListView(fillColor: .red, entries: entries)
            CircleListView(fillColor: .blue, entries: entries)
                .padding(.horizontal)
            CircleListView(fillColor: .green, entries: entries)
                .padding(.horizontal)
                .padding(.horizontal)
        }
    }
}
