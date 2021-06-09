//
//  CheckboxStyle.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 26/05/21.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    // MARK: - Propiedades
    
    // MARK: - Vista
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .gray : .white)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    //: Sonido y vibración al hacer tap
                    retroalimentacion.notificationOccurred(.success)
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        } //: HStack
    }
}

// MARK: - Vista preliminar
struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
