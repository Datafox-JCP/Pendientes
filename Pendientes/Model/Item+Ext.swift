//
//  Item+Ext.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 07/06/21.
//

import Foundation
import CoreData

// MARK: - Extension de Item para prioridad
extension Item {
    
    var priority: Priority {
        get {
            return Priority(rawValue: Int32(prioridad)) ?? .normal
        }
        
        set {
            prioridad = Int32(newValue.rawValue)
        }
    }
}
