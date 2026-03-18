import Foundation

// 1. ENTITY (Entidad)
// Parce, dividimos los datos según el diseño de Figma:
// 1. Anuncios (Carrusel)
struct Announcement: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let bullets: [String]
    let colorName: String // Pa' ponerle el tonito morado o azul
}

// 2. Accesos Rápidos (Grilla)
struct QuickAccessItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let colorName: String
}

// 3. Actividad Reciente (Lista)
struct RecentActivity: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let colorName: String
}
