//
//  TareasListRow.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 31/05/21.
//

import SwiftUI

struct ItemListRow: View {
    // MARK: - Elemento lista - Propiedades
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var pendientesItem: Item
    
    
    // MARK: - Elemento lista - Funciones
    //: Asigna el color dependiendo de la prioridad
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .alta: return .red
        case .normal: return .green
        case .baja: return .blue
        }
    }
    
    // MARK: - Elemento lista - Vista
    var body: some View {
        Toggle(isOn: $pendientesItem.terminada) {
            VStack(alignment: .leading) {
                HStack {
                    Text(pendientesItem.tarea ?? "")
                        .strikethrough(pendientesItem.terminada, color: .black)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.medium)
                        .animation(.default)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(self.color(for: pendientesItem.priority))
                } //: HStack
                if pendientesItem.recordatorio {
                    Text("Vence: \(pendientesItem.vencimiento!, formatter: formatoFecha)")
                        .font(.system(.callout, design: .rounded))
                }
            } //: VStack
        } //: Toggle
        .toggleStyle(CheckboxStyle())
        .onReceive(pendientesItem.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
        //: Para dejar ver el fondo de la vista princitpal
        .listRowBackground(Color.clear)
    }
}

