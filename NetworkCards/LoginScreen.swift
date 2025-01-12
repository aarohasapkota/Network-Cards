
import Foundation
import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var authManager: AuthManager// <-- Use EnvironmentObject
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToDeckLibrary = false

    var body: some View {
        ZStack {
            Color(hex: "5E17BC")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("EMAIL")
                    .foregroundColor(.white)
                TextField("EMAIL", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
                Text("PASSWORD")
                    .foregroundColor(.white)
                SecureField("PASSWORD", text: $password)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
                Button("Login") {
                    handleLogin()
                }
                .padding()
                .background(Color(hex: "21005D"))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .navigationDestination(isPresented: $navigateToDeckLibrary) {
                DeckLibrary()
            }
        }
    }

    private func handleLogin() {
        authManager.signIn(email: email, password: password) { success in
            if success {
                navigateToDeckLibrary = true
            } else {
                print("Login failed")
            }
        }
    }


}


struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
