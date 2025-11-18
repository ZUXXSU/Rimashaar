import SwiftUI

struct RegistrationView: View {
    @Binding var path: NavigationPath
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var emailOrPhone: String = ""
    
    @State private var firstNameError: String?
    @State private var lastNameError: String?
    @State private var emailPhoneError: String?
    
    @State private var phoneCode: String = "91"
    let countryCodes = ["91", "1", "44", "81", "33"]
    
    @State private var isLoading = false
    @State private var toastMessage: String?
    @State private var isShowingToast = false
    
    private let apiService = APIService()

    private func validateFields() -> Bool {
        firstNameError = firstName.isEmpty ? "First name cannot be empty." : (!firstName.isValidName() ? "First name can only contain letters." : nil)
        lastNameError = lastName.isEmpty ? "Last name cannot be empty." : (!lastName.isValidName() ? "Last name can only contain letters." : nil)
        emailPhoneError = (emailOrPhone.isValidEmail || emailOrPhone.isValidPhoneNumber) ? nil : "Please enter a valid 10-digit phone number or email address."
        
        return firstNameError == nil && lastNameError == nil && emailPhoneError == nil
    }
    
    private func registerUser() async {
        if validateFields() {
            isLoading = true
            
            let registrationData = RegistrationRequest(
                appVersion: "1.0",
                deviceModel: "iPhone",
                deviceToken: "",
                deviceType: "I",
                dob: "",
                email: emailOrPhone.isValidEmail ? emailOrPhone : "",
                firstName: firstName,
                gender: "",
                lastName: lastName,
                newsletterSubscribed: 0,
                osVersion: "17.0",
                password: "",
                phone: emailOrPhone.isValidPhoneNumber ? emailOrPhone : "",
                phoneCode: phoneCode
            )
            
            do {
                let response = try await apiService.registerUser(registrationData: registrationData)
                if let userData = response.data {
                    path.append(AppState.otp(
                        firstName: firstName,
                        lastName: lastName,
                        emailOrPhone: emailOrPhone,
                        phoneCode: phoneCode,
                        responseData: userData,
                        registrationData: registrationData
                    ))
                } else {
                    toastMessage = "Registration successful, but missing user data."
                    isShowingToast = true
                }
            } catch {
                toastMessage = error.localizedDescription
                isShowingToast = true
            }
            
            isLoading = false
        }
    }

    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Button(action: { path.removeLast() }) {
                                Image(systemName: "xmark")
                                    .imageScale(.large)
                                    .foregroundColor(.primary)
                            }
                        }

                        Image(Constants.Images.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)

                        VStack(alignment: .leading, spacing: 5) {
                            Text(Constants.Strings.signUp)
                                .font(.title2.weight(.semibold))
                            Text(Constants.Strings.pleaseEnterInfo)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 20) {
                            FormField(title: Constants.Strings.firstName, text: $firstName, error: $firstNameError)
                            FormField(title: Constants.Strings.lastName, text: $lastName, error: $lastNameError)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            Text(Constants.Strings.emailOrPhone)
                                .font(.caption)
                            HStack {
                                if emailOrPhone.isNumeric || emailOrPhone.isEmpty {
                                    CountryCodeMenu(phoneCode: $phoneCode, countryCodes: countryCodes)
                                }
                                TextField("", text: $emailOrPhone)
                                    .padding()
                                    .frame(height: 52)
                                    .keyboardType(emailOrPhone.isNumeric ? .phonePad : .emailAddress)
                                    .autocapitalization(.none)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(emailPhoneError == nil ? Color.gray.opacity(0.4) : .red, lineWidth: 1)
                                    )
                            }
                        }

                        Button(action: { Task { await registerUser() } }) {
                            Text(Constants.Strings.getOtp.uppercased())
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(.systemBrown))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(isLoading)

                        VStack {
                            ZStack {
                                Divider()
                                Text(Constants.Strings.orRegisterWith)
                                    .padding(.horizontal, 10)
                                    .background(Color(.systemBackground))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                        SocialLoginButtonsView()
                    }
                    .padding(20)
                }
                
                Spacer()
                
                HStack {
                    Text(Constants.Strings.haveAnAccount)
                        .foregroundColor(.secondary)
                    Button(action: { path.removeLast() }) {
                        Text(Constants.Strings.signIn)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, 20)
            }
            .disabled(isLoading)

            if isLoading {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                ProgressView().scaleEffect(2).tint(.white)
            }
            
            if isShowingToast {
                ToastView(message: toastMessage ?? "", isShowing: $isShowingToast)
            }
        }
        .navigationBarHidden(true)
    }
}

struct FormField: View {
    let title: String
    @Binding var text: String
    @Binding var error: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
            TextField("", text: $text)
                .padding()
                .frame(height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(error == nil ? Color.gray.opacity(0.4) : .red, lineWidth: 1)
                )
        }
    }
}

struct CountryCodeMenu: View {
    @Binding var phoneCode: String
    let countryCodes: [String]

    var body: some View {
        Menu {
            ForEach(countryCodes, id: \.self) { code in
                Button(action: { phoneCode = code }) {
                    Text("+\(code)")
                }
            }
        } label: {
            Text("+\(phoneCode)")
                .foregroundColor(.primary)
                .padding(.horizontal, 8)
                .frame(width: 70, height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }
}
