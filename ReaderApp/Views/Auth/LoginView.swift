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
        ZStack() {
                backgroundImageView(imageName: "reader")
      
            Group() {
                RotatedText(
                    text: viewModel.readerTitle,
                    font: Font.custom("PermanentMarker-Regular", size: 14),
                    color: .white,
                    textRotation: 15,
                    charRotation: -15)
                .padding(.top, -GridPoints.x5)
                .padding(.leading)
                
                RotatedText(
                    text: viewModel.appTitle,
                    font: Font.custom("PermanentMarker-Regular", size: 14),
                    color: .white,
                    textRotation: 90,
                    charRotation: -90)
            }
            .padding(.top, GridPoints.x4)
            .padding(.trailing, GridPoints.custom(18))
        }
        
            Group {
                EmailView(viewAdapter: authViewAdapter, userNameInput: $authViewAdapter.emailInput, customLabel: viewModel.emailLabel, textSize: 12)
                    .padding(.horizontal, GridPoints.x2)
                    .background(CustomColors.homeBackgroundColor)
                    .padding(.vertical)
                    
                PasswordView(viewAdapter: authViewAdapter, userNameInput: $authViewAdapter.passwordInput, customLabel: viewModel.passwordLabel, textSize: 12)
                    .padding(.horizontal, GridPoints.x2)
                    .background(CustomColors.homeBackgroundColor)
                    .padding(.bottom, GridPoints.x3)
            }
            .padding(.top, GridPoints.x2)
            
            Divider()
                .rotationEffect(Angle(degrees: -GridPoints.half))
            
        VStack(spacing: 16) {
                SimpleBtn(
                    width: GridPoints.custom(14),
                    label: viewModel.loginLabel,
                    fontStyle: .title3,
                    fontColor: .black,
                    bgColor: .white,
                    borderColor: .gray)
                    .onTapGesture {
                        if !authViewAdapter.emailInput.isEmpty && !authViewAdapter.passwordInput.isEmpty {
                            viewModel.loginAction { success in
                                if success {
                                    loggedIn = true
                                }
                            }
                        }
                    }
                
                SimpleBtn(
                    width: GridPoints.custom(10),
                    label: viewModel.registerLabel,
                    fontStyle: .caption,
                    fontColor: .white,
                    bgColor: .black,
                    borderColor: .white)
                .onTapGesture {
                    coordinator.present(fullScreenCover: .RegisterView)
                }
            }
            .padding(.top, GridPoints.x2)
            .padding(.bottom, GridPoints.x2)
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
        let readerTitle: String
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
