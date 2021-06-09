//
//  NewItemView.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 27/05/21.
//

import SwiftUI
import UserNotifications

struct NewItemView: View {
    // MARK: - Propiedades
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var esVisible: Bool
    
    let center = UNUserNotificationCenter.current()
    
    @State var tarea: String = ""
    @State var prioridadSeleccionada = 1
    @State private var disclosureExpandido = false
    @State private var recordatorioActivado = false
    @State private var fechaRecordatorio = Date()
    @State private var repetirRecordatorio = false
    @State private var keyboardHeight: CGFloat = 0
    
    private var botonDesactivado: Bool {
        tarea.isEmpty
    }
    
    // MARK: - Funciones
    private func guardarPendiente() {
        withAnimation {
            let nuevaTarea = Item(context: viewContext)
            nuevaTarea.tarea = tarea
            nuevaTarea.fecha = Date()
            nuevaTarea.prioridad = Int32(prioridadSeleccionada)
            nuevaTarea.terminada = false
            nuevaTarea.recordatorio = recordatorioActivado
            nuevaTarea.vencimiento = Date()
            nuevaTarea.repetir = repetirRecordatorio
            nuevaTarea.id = UUID()
            
            do {
                try viewContext.save()
                if recordatorioActivado {
                    programarNotificacion()
                }
            } catch {
                let nsError = error as NSError
                fatalError("Error no resuelto \(nsError), \(nsError.userInfo)")
            }
            tarea = ""
            hideKeyboard()
            esVisible = false
        }
    }
    
    private func activarRecordatorios() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notificaciones permitidas")
            } else {
                print("Notificaciones no permitidas")
            }
        }
    }
    
    func programarNotificacion() {
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Pendientes"
        content.body = tarea
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "pendientesApp"]
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
              [.day, .month, .year, .hour, .minute],
              from: fechaRecordatorio),
            repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    // MARK: - Vista
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: {
                        self.esVisible = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                } //: HStack
                TextField("Ingresa la tarea a realizar", text: $tarea)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .shadow(radius: radioSombra, x: xOffset, y: yOffset)
                
                Picker(selection: $prioridadSeleccionada, label: Text("")) {
                    Text("Alta").tag(2)
                    Text("Normal").tag(1)
                    Text("Baja").tag(0)
                }
                .background(Color.red)
                .cornerRadius(8.0)
                .pickerStyle(SegmentedPickerStyle())
                .labelsHidden()
                .shadow(radius: radioSombra, x: xOffset, y: yOffset)
                
                //: Recordatorios
                DisclosureGroup("Recordar", isExpanded: $disclosureExpandido) {
                    Toggle("Activar", isOn: $recordatorioActivado)
                        .onChange(of: recordatorioActivado, perform: { value in
                            activarRecordatorios()
                        })
                    .toggleStyle(SwitchToggleStyle(tint: Color.red))
                    
                    DatePicker("Seleccionar fecha", selection: $fechaRecordatorio)
                      .labelsHidden()
                      .padding(.vertical)
                        
                }
                    
                //: Botón Guardar
                Button(action: {
                    guardarPendiente()
                    playSound(sound: "sound-ding", type: "mp3")
                    retroalimentacion.notificationOccurred(.success)
                }, label: {
                    Spacer()
                    Text("Guardar")
                        .font(.system(.title2, design: .rounded))
                    Spacer()
                })
                .disabled(botonDesactivado)
                .onTapGesture {
                    playSound(sound: "sound-tap", type: "mp3")
                }
                .padding()
                .foregroundColor(.white)
                .background(botonDesactivado ? Color.gray : Color.red)
                .cornerRadius(8)
                .shadow(radius: radioSombra, x: xOffset, y: yOffset)
            } //: VStack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(fondoDegradado)
            .cornerRadius(8)
            .frame(maxWidth: 640)
        } //: VStack
        .padding()
        .accentColor(.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Vista preliminar
struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(esVisible: .constant(true), tarea: "", prioridadSeleccionada: 1)
    }
}
