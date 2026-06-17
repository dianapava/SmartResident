import SwiftUI

struct AuthView: View {
    @StateObject var presenter: AuthPresenter
  
    var body: some View {
        NavigationView {
            ZStack {
                Image(uiImage: UIImage(imageType: .backgroung_login)!)
                    .resizable()
                    .scaledToFit()
                Spacer()
                VStack {
                    LoginTitle()
                    LoginTextFields(email: $presenter.credentials.email, password: $presenter.credentials.password)
                    
                    // Si hay error, lo pintamos rojo
                    if let errorMessage = presenter.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                
                    ForgetPasswordButton()
                    
                  
                    
                    Button(action: {
                        // Acción para ir al registro
                    }) {
                        // Al usar el signo "+" concatenamos los textos manteniendo el comportamiento de un solo párrafo
                        (Text("¿No tienes una cuenta? ")
                            .foregroundColor(.white.opacity(0.6))
                         + Text("Regístrate")
                            .bold()
                            .foregroundColor(.white))
                        .font(.footnote)
                        .padding(.vertical, 12)
                    }
                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}


fileprivate struct LoginTitle: View {
    var body: some View {
        HStack{
            Text("Portal Exclusivo")
                .font(.title).bold()
                .foregroundColor(.white)
            Spacer()
        }
    }
}

fileprivate struct LoginTextFields: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Correo electrónico", text: $email)
                .padding()
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none) // Clave pa' que no ponga la primera letra mayúscula
                .glassEffect()
            SecureField("Contraseña", text: $password)
                .padding()
                .cornerRadius(10)
                .glassEffect()
        }
        .padding(.horizontal)
    }
}

fileprivate struct ForgetPasswordButton: View {
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                // Acción que le avisa al Presenter: "olvideContrasenaTapped"
            }) {
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote).bold()
                    .foregroundColor(.white) // Un blanco más suave
                    .padding(.vertical, 8) // Agranda el área táctil verticalmente
            }
        }
    }
}

fileprivate struct LoginButton: View {
    var body: some View {
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
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
