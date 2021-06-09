//
//  Constant.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 26/05/21.
//

import SwiftUI

// MARK: - Formato
let formatoFecha: DateFormatter = {
    let formato = DateFormatter()
    formato.dateStyle = .medium
    return formato
}()

// MARK: - UI
let coloresGradiente = Gradient(stops: [
                                    .init(color: .red, location: 0),
                                    .init(color: .orange, location: 0.90),
                                    .init(color: .yellow, location: 1)])

var  fondoDegradado: LinearGradient {
    return LinearGradient(gradient: coloresGradiente, startPoint: .top, endPoint: .bottom)
}

let radioSombra: CGFloat = 10
let xOffset: CGFloat = 12
let yOffset: CGFloat = 12

// MARK: - UX
let retroalimentacion = UINotificationFeedbackGenerator()
