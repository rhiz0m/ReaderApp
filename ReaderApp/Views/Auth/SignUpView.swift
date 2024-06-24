//
//  SignUpView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-15.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewAdapter: AuthViewAdapter
    @State var email = ""
    @State var confirmEmail = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var newRegistration = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let viewModel = viewAdapter.signUpViewModel {
            content(viewModel: viewModel)
            
        } else {
            ProgressView()
                .onAppear(perform: {
                    viewAdapter.generateSignUpViewModel()
                    
                })
        }
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 18) {
                VStack {
                    EmailView(
                        viewAdapter: viewAdapter,
                        userNameInput: $email,
                        customLabel: viewModel.emailTitle, textSize: 14)
                    .padding(.vertical)
                    EmailView(
                        viewAdapter: viewAdapter,
                        userNameInput: $confirmEmail,
                        customLabel: viewModel.confirmEmailTitle, textSize: 12)
                    .padding(.vertical)
                    PasswordView(
                        viewAdapter: viewAdapter,
                        userNameInput: $password,
                        customLabel: viewModel.passwordTitle, textSize: 14)
                    .padding(.bottom, GridPoints.x3)
                    PasswordView(
                        viewAdapter: viewAdapter,
                        userNameInput: $confirmPassword,
                        customLabel: viewModel.confirmPasswordTitle, textSize: 12)
                    .padding(.bottom, GridPoints.x3)
                }
                .padding(.horizontal, GridPoints.x2)
                Divider()
                    .rotationEffect(Angle(degrees: -GridPoints.x1))
                
                NavigationLink(
                    destination: HomeView(),
                    isActive: $newRegistration,
                    label: { EmptyView() }
                )
                .hidden()
                
                Text(viewModel.registerTitle)
                    .font(.title2)
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: Color.brown.opacity(0.6), radius: 8, x: 0, y: 2)
                    .onTapGesture {
                        if !email.isEmpty && email == confirmEmail && !password.isEmpty && password == confirmPassword {
                            viewModel.registerAction(email, password) { success in
                                if success {
                                    newRegistration = true
                                } else {
                                    
                                }
                            }
                        }
                    }
                
                Text(viewModel.cancelTitle)
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(.yellow)
                    .border(.white, width: 3)
                    .cornerRadius(8)
                    .padding(.bottom, GridPoints.x2)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .background(.yellow)
        }
        .padding(GridPoints.half)
        .navigationBarBackButtonHidden(true)
        
    }
    
    @ViewBuilder private func backgroundImageView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .yellow.opacity(0.2),
                            .yellow.opacity(1.8)]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.bottom)
            )
    }
    
    struct ViewModel {
        let appTitle: String
        let cancelTitle: String
        let registerTitle: String
        let passwordTitle: String
        let confirmPasswordTitle: String
        let emailTitle: String
        let confirmEmailTitle: String
        let registerAction: (String, String, @escaping (Bool) -> Void) -> Void
    }
}

#Preview {
    SignUpView(viewAdapter: AuthViewAdapter(emailInput: "", passwordInput: ""))
}
