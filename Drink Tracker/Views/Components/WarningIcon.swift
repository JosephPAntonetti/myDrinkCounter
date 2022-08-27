//
//  WarningIcon.swift
//  Drink Tracker
//
//  Created by Joseph Antonetti on 8/27/22.
//

import SwiftUI


struct WarningIcon: View {
    
    let status : Status
    
    private var backgroundIcon : String {
        get {
            switch (status) {
            case .ok:
                return "circle.fill"
            case .warning:
                return "triangle.fill"
            }
        }
    }
    
    private var foregroundIcon : String {
        get {
            switch(status) {
            case .ok:
                return "checkmark.circle.fill"
            case .warning:
                return "exclamationmark.triangle.fill"
            }
        }
    }
    
    private var foregroundColor : Color {
        get {
            switch(status) {
            case .ok:
                return .green
            case .warning:
                return .orange
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image(systemName: backgroundIcon)
                .foregroundColor(.black)
            Image(systemName: foregroundIcon)
                .foregroundColor(foregroundColor)
        }
    }
    
    enum Status {
        case ok
        case warning
    }
}

struct WarningIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WarningIcon(status: .ok)
                .font(.system(size: 36))
            WarningIcon(status: .warning)
                .font(.system(size: 14))
        }
    }
}
