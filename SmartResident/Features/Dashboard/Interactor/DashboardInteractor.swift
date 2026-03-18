import Foundation

// 2. INTERACTOR (El cerebro del negocio)
// Mija, aquí simulamos que pedimos los datos al servidor.
class DashboardInteractor {
    
    // Obtenemos los anuncios del carrusel
    func fetchAnnouncements() -> [Announcement] {
        return [
            Announcement(
                title: "Convivencia Vecinal",
                subtitle: "Recordemos mantener:",
                bullets: ["Respeto mutuo", "Volumen moderado después de 10 PM", "Áreas comunes limpias"],
                colorName: "purple" // Luego mapeamos esto a colores reales de SwiftUI
            )
        ]
    }
    
    // Obtenemos los cuadritos de accesos rápidos
    func fetchQuickAccessItems() -> [QuickAccessItem] {
        return [
            QuickAccessItem(title: "Mis Paquetes", subtitle: "Ver correspondencia", iconName: "shippingbox", colorName: "blue"),
            QuickAccessItem(title: "Reservar Zona", subtitle: "Áreas comunes", iconName: "calendar", colorName: "purple"),
            QuickAccessItem(title: "Agendar Cita", subtitle: "Administración", iconName: "clock", colorName: "orange")
        ]
    }
    
    // Obtenemos las últimas notificaciones
    func fetchRecentActivities() -> [RecentActivity] {
        return [
            RecentActivity(title: "Nuevo paquete recibido", subtitle: "Amazon - Hace 2 horas", iconName: "shippingbox", colorName: "blue"),
            RecentActivity(title: "Reserva confirmada", subtitle: "Salón Social - 8 Mar, 6:00 PM", iconName: "calendar", colorName: "purple")
        ]
    }
}
