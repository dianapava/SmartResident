import SwiftUI

// 4. VIEW (La fachada)
// Parce, esta vista es muda. Solo pinta lo que el Presenter le diga y le avisa cuando el usuario hace tap.
struct DashboardView: View {
    @StateObject var presenter: DashboardPresenter
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Contenido principal scrolleable
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // 1. Sección Anuncios (Carrusel)
                    AnnouncementsSection(announcements: presenter.announcements)
                    
                    // 2. Sección Accesos Rápidos (Grilla)
                    QuickAccessSection(items: presenter.quickAccessItems) { item in
                        presenter.quickAccessTapped(item)
                    }
                    
                    // 3. Sección Actividad Reciente (Lista)
                    RecentActivitySection(activities: presenter.recentActivities)
                    
                    // Espacio al final para que el scroll no quede tapado por el TabBar o FAB
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            // 4. Botón Flotante de WhatsApp (FAB)
            Button(action: {
                presenter.whatsappButtonTapped()
            }) {
                Image(systemName: "message.circle.fill") // Simulando logo de WhatsApp
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                    .background(Circle().fill(Color.white))
                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
        .navigationTitle("Inicio")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            presenter.onAppear()
        }
    }
}

// MARK: - Sub-vistas (Components)
// Parce, separamos las vistas chiquitas aquí pa' que la principal no parezca un sancocho.

// 1. Carrusel de Anuncios
struct AnnouncementsSection: View {
    let announcements: [Announcement]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Anuncios Importantes")
                .font(.title3)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(announcements) { announcement in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "heart")
                                    .padding(10)
                                    .background(Circle().fill(Color.white))
                                    .foregroundColor(.purple)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            
                            Text(announcement.title)
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            Text(announcement.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            ForEach(announcement.bullets, id: \.self) { bullet in
                                Text("• \(bullet)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(width: 280)
                        .background(Color.purple.opacity(0.05))
                        .cornerRadius(16)
                    }
                }
            }
        }
    }
}

// 2. Grilla de Accesos Rápidos
struct QuickAccessSection: View {
    let items: [QuickAccessItem]
    let onTapped: (QuickAccessItem) -> Void
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Accesos Rápidos")
                .font(.title3)
                .fontWeight(.bold)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    Button(action: { onTapped(item) }) {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: item.iconName)
                                .padding(12)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                            
                            Text(item.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                        // Borde sutil como en Figma
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                    }
                }
            }
        }
    }
}

// 3. Actividad Reciente
struct RecentActivitySection: View {
    let activities: [RecentActivity]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Actividad Reciente")
                .font(.title3)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                ForEach(activities) { activity in
                    HStack(spacing: 16) {
                        Image(systemName: activity.iconName)
                            .padding(12)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(activity.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text(activity.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.03), radius: 3, x: 0, y: 1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                    )
                }
            }
        }
    }
}
