//
//  AuthViewAdapter.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-15.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class AuthViewAdapter: ObservableObject {
//    @Published var coordinator: Coordinator
    @Published var loginViewModel: LoginView.ViewModel?
    @Published var registerViewModel: RegisterView.ViewModel?
    @Published var emailInput: String
    @Published var passwordInput: String
    @Published var currentUserData: UserData?
    @Published var currentUser: User?
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private let USER_DATA_COLLECTION = "user_data"
    private let USER_EXERCISES = "usersExercises"
    private var dbListener: ListenerRegistration?
    

    init(/*coordinator: Coordinator, */emailInput: String = "", passwordInput: String = "") {
//        self.coordinator = coordinator
        self.emailInput = emailInput
        self.passwordInput = passwordInput
        self.setupAuthStateListener()
    }
    
    private func setupAuthStateListener() {
        auth.addStateDidChangeListener { auth, user in
            if let user = user {
                print("A user has been logged in \(user.email ?? "No Email")")
                self.currentUser = user
                self.startListeningToDb()
            } else {
                self.dbListener?.remove()
                self.dbListener = nil
                self.currentUserData = nil
                self.currentUser = nil
                print("A user has logged out")
            }
        }
    }
    
    // DB
    
    func startListeningToDb() {
        guard let user = currentUser else { return }
        
        let documentPath = "\(USER_DATA_COLLECTION)/\(user.uid)"
        print("Listening to Firestore document: \(documentPath)")
        print("Document path: \(documentPath)")
        
        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let documentSnapshot = snapshot else { return }
            
            let result = Result {
                try documentSnapshot.data(as: UserData.self)
            }
            
            switch result {
            case .success(let userData):
                self.currentUserData = userData
                
            case .failure(let error):
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
    
    
    func generateLoginViewModel() {
        let loginViewModel = LoginView.ViewModel(
            readerTitle: "Re der",
            appTitle: "App",
            loginLabel: "Login",
            registerLabel: "Sign Up",
            passwordLabel: "Password",
            emailLabel: "Email",
            loginAction: { [weak self] completion in
                guard let self = self else { return }
                self.loginUser(
                    email: self.emailInput,
                    password: self.passwordInput) { success in
                        completion(success)
                    }
            }
        )
        self.loginViewModel = loginViewModel
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error logging in:", error.localizedDescription)
                completion(false)
            } else {
                print("You are logged in!")
                completion(true)
            }
        }
    }
    
    func generateRegisterViewModel() {
        let signUpViewModel = RegisterView.ViewModel(
            appTitle: "Reader App",
            cancelTitle: "Cancel",
            registerTitle: "Sign Up",
            passwordTitle: "Password",
            confirmPasswordTitle: "Confirm Password",
            emailTitle: "Email",
            confirmEmailTitle: "Confirm Email",
            
            registerAction: { [weak self] email, password, completion in
                guard let self = self else { return }
                self.registerUser(email: email, password: password) { success in
                    completion(success)
                }
            }
        )
        self.registerViewModel = signUpViewModel
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
            
            if authResult != nil {
                completion(true)
            }
        }
    }
    
    func logout() {
        do {
            emailInput = ""
            passwordInput = ""
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Error logout: \(error.localizedDescription)")
        }
    }
}
