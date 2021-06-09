//
//  BlankView.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 29/05/21.
//

import SwiftUI

struct BlankView: View {
    // MARK: - Propiedades
    var bgColor: Color
    var bgOpacidad: Double
    
    // MARK: - Vista
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .opacity(bgOpacidad)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Vista preilinar
struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(bgColor: Color.black, bgOpacidad: 0.5)
            .previewDevice("iPhone 12 mini")
    }
}
