//
//  SignUpView.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-04-15.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @State var email = ""
    @State var confirmEmail = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var newRegistration = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            if let viewModel = authViewAdapter.registerViewModel {
                content(viewModel: viewModel)
            } else {
                ProgressView()
                    .onAppear(perform: {
                        authViewAdapter.generateRegisterViewModel()
                    })
            }
        }
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        ZStack {
            CustomColors.homeBackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Group {
                    EmailView(
                        viewAdapter: authViewAdapter,
                        userNameInput: $email,
                        customLabel: viewModel.emailTitle, textSize: 14)
                    .padding(.vertical)
                    EmailView(
                        viewAdapter: authViewAdapter,
                        userNameInput: $confirmEmail,
                        customLabel: viewModel.confirmEmailTitle, textSize: 12)
                    .padding(.vertical)
                    PasswordView(
                        viewAdapter: authViewAdapter,
                        userNameInput: $password,
                        customLabel: viewModel.passwordTitle, textSize: 14)
                    .padding(.bottom, GridPoints.x3)
                    PasswordView(
                        viewAdapter: authViewAdapter,
                        userNameInput: $confirmPassword,
                        customLabel: viewModel.confirmPasswordTitle, textSize: 12)
                    .padding(.bottom, GridPoints.x3)
                }
                .padding(.horizontal, GridPoints.x1)

                
                Divider()
                    .rotationEffect(Angle(degrees: -GridPoints.half))
                
                
                VStack(spacing: 16) {
                    SimpleBtn(
                        width: GridPoints.custom(14),
                        label: viewModel.registerTitle,
                        fontStyle: Font.custom("PermanentMarker-Regular", size: 16),
                        fontColor: .black,
                        bgColor: CustomColors.defaultGreen,
                        borderColor: .green)
                    .onTapGesture {
                        if !email.isEmpty && email == confirmEmail && !password.isEmpty && password == confirmPassword {
                            viewModel.registerAction(email, password) { success in
                                if success {
                                    newRegistration = true
                                    coordinator.dismissFullScreenCover()
                                } else {
                                    
                                }
                            }
                        }
                    }
                    
                    SimpleBtn(
                        width: GridPoints.custom(10),
                        label: viewModel.cancelTitle,
                        fontStyle: Font.custom("PermanentMarker-Regular", size: 14),
                        fontColor: .white,
                        bgColor: .black,
                        borderColor: .white)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(.top, GridPoints.x8)
            }
            .padding(.top)
        }
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
    RegisterView(authViewAdapter: AuthViewAdapter())
}
