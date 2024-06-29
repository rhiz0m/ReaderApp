//
//  LoginView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-15.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @EnvironmentObject var coordinator: Coordinator
    @State private var loggedIn = false
    
    var body: some View {
        if let viewModel = authViewAdapter.loginViewModel {
            content(viewModel: viewModel)
                .background(
                    NavigationLink(value: Screens.HomeView) {
                        EmptyView()
                    }
                        .opacity(0)
                )
                .onChange(of: loggedIn) {
                        coordinator.push(.HomeView)
                }
        } else {
            ProgressView()
                .onAppear {
                    authViewAdapter.generateLoginViewModel()
                }
        }
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        ZStack(alignment: .leading) {
                backgroundImageView(imageName: "reader")
                
                RotatedText(
                    text: viewModel.appTitle,
                    font: Font.custom("PermanentMarker-Regular", size: 16),
                    color: .white)
            }
            VStack(spacing: 18) {
                VStack {
                    EmailView(viewAdapter: authViewAdapter, userNameInput: $authViewAdapter.emailInput, customLabel: viewModel.emailLabel, textSize: 14)
                        .padding(.vertical)
                    PasswordView(viewAdapter: authViewAdapter, userNameInput: $authViewAdapter.passwordInput, customLabel: viewModel.passwordLabel, textSize: 12)
                        .padding(.bottom, GridPoints.x3)
                }
                .padding(.horizontal, GridPoints.x2)
                Divider()
                    .rotationEffect(Angle(degrees: -GridPoints.x1))
                Text(viewModel.loginLabel)
                    .font(.title2)
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: Color.brown.opacity(0.6), radius: 8, x: 0, y: 2)
                    .onTapGesture {
                        if !authViewAdapter.emailInput.isEmpty && !authViewAdapter.passwordInput.isEmpty {
                            viewModel.loginAction { success in
                                if success {
                                    loggedIn = true
                                }
                            }
                        }
                    }
                Button(action: {
                    coordinator.present(fullScreenCover: .RegisterView)
                }) {
                    Text(viewModel.registerLabel)
                }
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
                            CustomColors.homeBackgroundColor.opacity(1.8)
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.bottom)
            )
    }
    
    struct ViewModel {
        let appTitle: String
        let loginLabel: String
        let registerLabel: String
        let passwordLabel: String
        let emailLabel: String
        let loginAction: (@escaping (Bool) -> Void) -> Void
    }
}

#Preview {
    LoginView(authViewAdapter: AuthViewAdapter())
}
