

import Foundation
import SwiftUI
struct RegistrationScreen: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToDeckLibrary = false

    var body: some View {
        
        ZStack {
            Color(hex: "5E17BC")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("FULL NAME")
                    .foregroundColor(.white)
                TextField("FULL NAME", text: $fullname)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
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
                
                Button("Register") {
                    handleRegistration()
                }
                .padding()
                .background(Color(hex: "65558F"))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .navigationDestination(isPresented: $navigateToDeckLibrary) {
                DeckLibrary()
            }
        }
    }

    private func handleRegistration() {
        authManager.signUp(email: email, password: password) { success in
            if success {
                navigateToDeckLibrary = true
            } else {
                print("Registration failed")
            }
        }
    }


}


struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
    }
}
