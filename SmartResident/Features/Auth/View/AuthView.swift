import SwiftUI

// VIEW (La pantalla)
struct AuthView: View {
    @StateObject var presenter: AuthPresenter
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "building.2.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("SmartResident")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 15) {
                    TextField("Correo electrónico", text: $presenter.credentials.email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none) // Clave pa' que no ponga la primera letra mayúscula
                    
                    SecureField("Contraseña", text: $presenter.credentials.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Si hay error, lo pintamos rojo
                if let errorMessage = presenter.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    presenter.loginTapped()
                }) {
                    if presenter.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Ingresar")
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                // 🛑 BOTÓN TRAMPA PARA PROBAR EL PR REVIEWER DE GEMINI
                Button(action: {
                    // MALA PRÁCTICA VIPER: Lógica directa en la vista
                    if presenter.credentials.email == "admin@test.com" {
                        print("Login directo sin pasar por el Presenter ni el Interactor. ¡Pecado en VIPER!")
                    }
                }) {
                    Text("Botón Trampa VIPER")
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
