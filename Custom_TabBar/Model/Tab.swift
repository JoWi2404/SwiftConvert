//
//  Tab.swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 15/05/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case tab_length = "Length"
    case tab_temp = "Temperature"
    case tab_currency = "Currency"
    
    var systemImage : String {
        switch self {
        case .tab_length:
            return "pencil.and.ruler"
        case .tab_temp:
            return "drop.degreesign.fill"
        case .tab_currency:
            return "dollarsign"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
