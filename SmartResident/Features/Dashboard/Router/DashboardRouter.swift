import Foundation
import SwiftUI

// 5. ROUTER (El conductor)
// Este parce junta todas las piezas de VIPER como si fuera Lego y dice pa' dónde vamos.
class DashboardRouter {

    @MainActor
    static func build() -> some View {
        let router = DashboardRouter()
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(interactor: interactor, router: router)
        let dashboardView = DashboardView(presenter: presenter)
        
        // Parce, aquí armamos el TabBar de abajo como en el diseño 
        return TabView {
            dashboardView
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }
            
            Text("Pantalla Paquetería en construcción 🚧")
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Paquetería")
                }
            
            Text("Pantalla Zonas en construcción 🚧")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Zonas")
                }
                
            Text("Pantalla Citas en construcción 🚧")
                .tabItem {
                    Image(systemName: "clock")
                    Text("Citas")
                }
        }
    }
}
