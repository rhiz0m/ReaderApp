//
//  AuthViewAdapter.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-15.
//

import Foundation

class AuthViewAdapter: ObservableObject {
    
    @Published var loginViewModel: LoginView.ViewModel?
    @Published var signUpViewModel: SignUpView.ViewModel?
    @Published var emailInput: String
    @Published var passwordInput: String
    
    init(
         emailInput: String,
         passwordInput: String
    ) {
        self.emailInput = emailInput
        self.passwordInput = passwordInput
    }

    func generateLoginViewModel() {
        let loginViewModel = LoginView.ViewModel(
            appTitle: "Read Speedster",
            loginLabel: "Login",
            signUpLabel: "Sign Up",
            passwordLabel: "Password",
            emailLabel: "Email")
        
        self.loginViewModel = loginViewModel
    }
    
    func generateSignUpViewModel() {
        let signUpViewModel = SignUpView.ViewModel(
            appTitle: "Read Speedster",
            cancelLabel: "Cancel",
            signUpLabel: "Sign Up",
            passwordLabel: "Password",
            confirmPassword: "Confirm Password",
            emailLabel: "Email",
            confirmEmail: "Confirm Email"
        )
        
        self.signUpViewModel = signUpViewModel
    }
}
