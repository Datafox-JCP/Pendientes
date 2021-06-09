//
//  HideKeyboard+Ext.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 27/05/21.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
