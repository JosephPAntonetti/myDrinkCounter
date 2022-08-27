//
//  ActionButton.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/23/22.
//

import SwiftUI

enum ActionButtonStyle {
    case primary
    case secondary
}

struct ActionButton: View {
    
    let label : LocalizedStringKey
    let style : ActionButtonStyle
    let onPress : () -> Void
    
    private var text : Text {
        get {
            Text(label)
                .font(.system(.body, design: .rounded))
                .bold()
        }
    }
    
    var body: some View {
        switch (style) {
        case .primary:
            Button(action: onPress)
            {
                text
                #if os(iOS)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                #endif
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        case .secondary:
            Button(action: onPress)
            {
                text
                    .padding(.horizontal)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ActionButton(label: "TODAY", style: .primary) {
                
            }
            ActionButton(label: "TODAY", style: .secondary) {
                
            }
        }
    }
}
