//
//  ListSection.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/20/22.
//

import SwiftUI

struct ListSection<Content : View>: View {
    
    let title : LocalizedStringKey
    @ViewBuilder let content : () -> Content
    
    var body: some View {
        Section(content: content,
                header:{
                    Text(self.title)
                        .font(.system(.title3, design: .rounded)
                            .bold())
                        .foregroundColor(.primary)
                        .textCase(.none)
        })
    }
}

struct ListSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListSection(title: "Hello") {
                Text("One")
            }
        }
    }
}
