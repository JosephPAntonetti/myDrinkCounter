//
//  Settings.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/20/22.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
            List {
                ListSection(title: "ABOUT_SECTION"){
                    HStack {
                        Image(uiImage: Bundle.main.icon!)
                            .cornerRadius(15)
                            .padding(.horizontal, 15)
                        VStack(alignment: .center) {
                            Text("APP_NAME")
                                .font(.system(.title, design: .rounded))
                                .bold()
                            Text("CREATED_BY_SUBTITLE")
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    Text("OPEN_SOURCE_DESCRIPTION")
                    Button("OPEN_SOURCE_CTA"){
                        UIApplication.shared.openURL(URL(string:"https://github.com/JosephPAntonetti/DrinkTracker/tree/main")!)
                    }
                }
            }
            .navigationTitle("SETTINGS_TITLE")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
