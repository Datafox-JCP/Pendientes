//
//  NoDataView.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 27/05/21.
//

import SwiftUI

struct NoDataView: View {
    
    // MARK: - Propiedades
    @State var animate: Bool = false
    
    let primario = Color("PrimaryAnim")
    let secundario = Color("SecondaryAnim")
    
    // MARK: - Funciones
    func animacion() {
        // Para no ejecutar dos veces
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 3.0)
                    .repeatCount(5)
            ) {
                animate.toggle()
            }
        }
    }
    
    // MARK: - Vista
    var body: some View {
            VStack(spacing: 10) {
                Text("¡Nada pendiente 👏🏻!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? primario : secundario)
                    .cornerRadius(10)
                    .padding(animate ? 30: 50)
                    .shadow(color: animate ? primario.opacity(0.7) : secundario.opacity(0.7), radius: animate ? 30 : 10, x: 0, y: animate ? 50: 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
            }
            .padding(30)
            .onAppear(perform: {
                animacion()
            })
    }

}

// MARK: - Vista preliminar
struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}
