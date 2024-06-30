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
        VStack {
            ZStack {
                CustomColors.homeBackgroundColor
                
                backgroundImageView(imageName: viewModel.bgImage)
                    .clipShape(Circle())
                    .padding(GridPoints.x2)
                    
                Group() {
                    RotatedText(
                        text: viewModel.readerTitle,
                        font: .headline,
                        fontWeight: .semibold,
                        color: .black,
                        textRotation: 30,
                        charRotation: -30)
                    .padding(.bottom, GridPoints.x5)
                    .padding(.leading)
                    
                    RotatedText(
                        text: viewModel.appTitle,
                        font: .callout,
                        fontWeight: .medium,
                        color: .white,
                        textRotation: 90,
                        charRotation: -90)
                }
                
                .padding(.bottom, GridPoints.custom(12))
                .padding(.leading, GridPoints.custom(18))
            }
            
            EmailView(viewAdapter: authViewAdapter, userNameInput: $authViewAdapter.emailInput, customLabel: viewModel.emailLabel, textSize: 12)
                .padding(.horizontal)
                .padding(.bottom)
            
            PasswordView(viewAdapter: authViewAdapter, userNameInput: $authViewAdapter.passwordInput, customLabel: viewModel.passwordLabel, textSize: 12)
                .padding(.horizontal)
                .background(CustomColors.homeBackgroundColor)
            
            Divider()
                .rotationEffect(Angle(degrees: -GridPoints.half))
                .padding()
            
            
            SimpleBtn(
                width: GridPoints.custom(14),
                label: viewModel.loginLabel,
                fontStyle: Font.custom("PermanentMarker-Regular", size: 16),
                fontColor: .black,
                bgColor: CustomColors.defaultGreen,
                borderColor: Color.green)
            .onTapGesture {
                if !authViewAdapter.emailInput.isEmpty && !authViewAdapter.passwordInput.isEmpty {
                    viewModel.loginAction { success in
                        if success {
                            loggedIn = true
                        }
                    }
                }
            }
            .padding(.bottom, GridPoints.x1)
            
            SimpleBtn(
                width: GridPoints.custom(10),
                label: viewModel.registerLabel,
                fontStyle: Font.custom("PermanentMarker-Regular", size: 14),
                fontColor: CustomColors.defaultGreen,
                bgColor: .black,
                borderColor: .white)
            .onTapGesture {
                coordinator.present(fullScreenCover: .RegisterView)
            }
            .padding(.bottom, GridPoints.x3)
            
        }
    }
    
    @ViewBuilder private func backgroundImageView(imageName: String) -> some View {
        ZStack {
            Color.black
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.bottom)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color.brown.opacity(0.2),
                                    CustomColors.defaultGreen.opacity(0.3)
                                ]
                            ),
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
            }
        }
    }
    
    struct ViewModel {
        let bgImage: String
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
