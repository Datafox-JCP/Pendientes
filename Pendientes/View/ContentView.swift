//
//  ContentView.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 26/05/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Propiedades
    //: Para transparencia en la lista
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .none
    }
    
    //: CoreData
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.vencimiento, ascending: false)])
    private var tareas: FetchedResults<Item>
    
    @State private var mostarNuevaTarea: Bool = false
    @State private var mostrarSettings: Bool = false
    
    // MARK: - Funciones
    //: Borrar
    private func borrarTareas(offsets: IndexSet) {
        withAnimation {
            offsets.map { tareas[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Vista
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Vista principal
                fondoDegradado
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Lista pendientes
                    if tareas.isEmpty {
                        //: Si no hay datos mostrar vista alterna
                        NoDataView()
                            .transition(AnyTransition.opacity.animation(.easeIn))
                        Spacer()
                    } else {
                        List {
                            ForEach(tareas) { item in
                                ItemListRow(pendientesItem: item)
                            }
                            .onDelete(perform: borrarTareas)
                        } //: List
                        .listStyle(InsetGroupedListStyle())
                    }
                } //: VStack
                
                // MARK: - FAB Nueva tarea
                if !mostarNuevaTarea {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                self.mostarNuevaTarea = true
                                playSound(sound: "sound-ding", type: "mp3")
                                retroalimentacion.notificationOccurred(.success)
                            }){
                                Image(systemName: "plus")
                                    .font(.largeTitle)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Circle())
                            .foregroundColor(.red)
                            .shadow(radius: radioSombra, x: xOffset, y: yOffset)
                        }
                        .padding(.trailing, 10)
                        .padding(.bottom, 10)
                    } //: VStack
                }
                //: Para ocultar el botón
                Toggle("", isOn: $mostarNuevaTarea)
                    .hidden() // para mantener oculto el Toggle
                // Mostrar la vista para Nuevo
                if mostarNuevaTarea {
                    BlankView(bgColor: .black, bgOpacidad: 0.7)
                        .onTapGesture {
                            mostarNuevaTarea = false
                        }
                    NewItemView(esVisible: $mostarNuevaTarea)
                }
            } //: ZStack
            .navigationTitle("Pendientes")
            .ignoresSafeArea(edges: .bottom)
            .toolbar {
                ToolbarItem {
                    Button(action: { mostrarSettings = true }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $mostrarSettings) {
                SettingsView()
            }
        } //: Navigation
        .accentColor(.yellow)
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

// MARK: - Vista preliminar
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
}

// MARK: - Enum para prioridad
enum Priority: Int32 {
    case baja = 0
    case normal = 1
    case alta = 2
}


