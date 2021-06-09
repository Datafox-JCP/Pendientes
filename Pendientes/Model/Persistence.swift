//
//  Persistence.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 26/05/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<15 {
            let nuevaTarea = Item(context: viewContext)
            nuevaTarea.id = UUID()
            nuevaTarea.tarea = ("Pendiente... #\(i)")
            nuevaTarea.prioridad = 0
            nuevaTarea.terminada = false
            nuevaTarea.recordatorio = false
            nuevaTarea.vencimiento = Date()
            nuevaTarea.repetir = false
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Pendientes")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
