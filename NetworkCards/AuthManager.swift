
import Foundation

import FirebaseAuth // <-- Import Firebase Auth


class AuthManager: ObservableObject{

    // A property to store the logged in user. User is an object provided by FirebaseAuth framework
    @Published var user: User?

    // Determines if AuthManager should use mocked data
    let isMocked: Bool

    var userEmail: String? {

        // If mocked, return a mocked email string, otherwise return the users email if available
        isMocked ? "kingsley@dog.com" : user?.email
    }

    init(isMocked: Bool = false) {
        self.isMocked = isMocked
        self.user = Auth.auth().currentUser // Retrieve cached user
    }


    // https://firebase.google.com/docs/auth/ios/start#sign_up_new_users
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                DispatchQueue.main.async {
                    self.user = authResult.user
                    completion(true) // Notify success
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(false) // Notify failure
                }
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                DispatchQueue.main.async {
                    self.user = authResult.user
                    completion(true) // Notify success
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(false) // Notify failure
                }
            }
        }
    }


    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil // <-- Set user to nil after sign out
        } catch {
            print(error)
        }
    }
}
