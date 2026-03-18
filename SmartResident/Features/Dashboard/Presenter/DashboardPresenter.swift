import Foundation
import Combine
// 3. PRESENTER (El intermediario)
// Conecta el Interactor con la Vista. Acomoda los datos pa' que la vista los pinte fácil.
class DashboardPresenter: ObservableObject {
    @Published var announcements: [Announcement] = []
    @Published var quickAccessItems: [QuickAccessItem] = []
    @Published var recentActivities: [RecentActivity] = []
    
    private let interactor: DashboardInteractor
    private let router: DashboardRouter
    
    init(interactor: DashboardInteractor, router: DashboardRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onAppear() {
        // Le pedimos los datos al Interactor
        self.announcements = interactor.fetchAnnouncements()
        self.quickAccessItems = interactor.fetchQuickAccessItems()
        self.recentActivities = interactor.fetchRecentActivities()
    }
    
    func quickAccessTapped(_ item: QuickAccessItem) {
        print("Mija, tocaron \(item.title)")
    }
    
    func whatsappButtonTapped() {
        print("¡Abriendo WhatsApp de la portería!")
        // Aquí meteríamos el código real para abrir la URL de WhatsApp (ej. wa.me/...)
    }
}
