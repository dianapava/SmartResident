//
//  SmartResidentApp.swift
//  SmartResident
//
//  Created by Diana Alejandra Pava A on 16/03/26.
//

import SwiftUI
import FirebaseCore // Importamos el núcleo de Firebase

@main
struct SmartResidentApp: App {
    
    // Observamos el portero global
    @StateObject private var sessionManager = SessionManager.shared
    
    // Este `init` se ejecuta antes de que se muestre cualquier pantalla
    init() {
        FirebaseApp.configure()
        print("🔥 ¡Firebase configurado al cien, parce!")
    }
    
    var body: some Scene {
        WindowGroup {
            // Aquí está la magia: dependiendo del estado, mostramos el Dashboard o el Login
            if sessionManager.isLoggedIn {
                DashboardRouter.build()
            } else {
                AuthRouter.build()
            }
        }
    }
}
