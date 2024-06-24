//
//  SignUpView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-15.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewAdapter: AuthViewAdapter
    
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
                        EmailView(viewAdapter: viewAdapter, userNameInput: $viewAdapter.emailInput, customLabel: viewModel.emailLabel, textSize: 14)
                            .padding(.vertical)
                        EmailView(viewAdapter: viewAdapter, userNameInput: $viewAdapter.emailInput, customLabel: viewModel.confirmEmail, textSize: 12)
                            .padding(.vertical)
                        PasswordView(viewAdapter: viewAdapter, userNameInput: $viewAdapter.passwordInput, customLabel: viewModel.passwordLabel, textSize: 14)
                            .padding(.bottom, GridPoints.x3)
                        PasswordView(viewAdapter: viewAdapter, userNameInput: $viewAdapter.passwordInput, customLabel: viewModel.confirmPassword, textSize: 12)
                            .padding(.bottom, GridPoints.x3)
                    }
                    .padding(.horizontal, GridPoints.x2)
                    Divider()
                        .rotationEffect(Angle(degrees: -GridPoints.x1))
                    Text(viewModel.signUpLabel)
                        .font(.title2)
                        .bold()
                        .padding(.vertical, GridPoints.x1)
                        .padding(.horizontal, GridPoints.x3)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(color: Color.brown.opacity(0.6), radius: 8, x: 0, y: 2)
                    Text(viewModel.cancelLabel)
                        .bold()
                        .padding(.vertical, GridPoints.x1)
                        .padding(.horizontal, GridPoints.x3)
                        .background(CustomColors.homeBackgroundColor)
                        .border(.white, width: 3)
                        .cornerRadius(8)
                 
                        .padding(.bottom, GridPoints.x2)
                }
                .background(CustomColors.homeBackgroundColor)
                .padding(.bottom, GridPoints.x8)
            }
        .padding(GridPoints.half)
         
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
                            CustomColors.homeBackgroundColor.opacity(0.2),
                            CustomColors.homeBackgroundColor.opacity(1.8)]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.bottom)
            )
    }
    
    struct ViewModel {
        let appTitle: String
        let cancelLabel: String
        let signUpLabel: String
        let passwordLabel: String
        let confirmPassword: String
        let emailLabel: String
        let confirmEmail: String
    }
}

#Preview {
    SignUpView(viewAdapter: AuthViewAdapter(emailInput: "", passwordInput: ""))
}
