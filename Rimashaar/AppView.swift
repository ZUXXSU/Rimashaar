import SwiftUI

struct AppView: View {
    @State private var showSplash = true
    @State private var selectedCountry: String = UserDefaults.standard.string(forKey: "selectedCountry") ?? "India"
    @State private var selectedStore: String = UserDefaults.standard.string(forKey: "selectedStore") ?? "Rimashaar Jewellery , location 1"
    @State private var path = NavigationPath()
    @State private var isConfigured: Bool = false

    var body: some View {
        if showSplash {
            SplashScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            showSplash = false
                        }
                    }
                }
        } else {
            NavigationStack(path: $path) {
                Group{
                    if isConfigured {
                        WelcomeScreen(path: $path)
                    } else {
                        ContentView(selectedCountry: $selectedCountry, selectedStore: $selectedStore, path: $path)
                    }}
                .navigationDestination(for: AppState.self) { screen in
                    switch screen {
                    case .startScreenOne:
                        ContentView(selectedCountry: $selectedCountry, selectedStore: $selectedStore, path: $path)
                    case .selectCountry:
                        SelectCountry(selectedCountry: $selectedCountry)
                    case .selectStore:
                        SelectStore(selectedStore: $selectedStore, path: $path)
                    case .welcomeScreen:
                        WelcomeScreen(path: $path)
                    case .registration:
                        RegistrationView(path: $path)
                    case .otp(let firstName, let lastName, let emailOrPhone,let phoneCode, let responseData, let registrationData):
                        OtpView(path: $path, firstName: firstName, lastName: lastName, emailOrPhone: emailOrPhone,phoneCode : phoneCode, responseData: responseData, registrationData: registrationData)
                    }
                }
            }
            .onAppear {
                if UserDefaults.standard.string(forKey: "selectedCountry") != nil &&
                   UserDefaults.standard.string(forKey: "selectedStore") != nil {
                    isConfigured = true
                }
            }
        }
    }
}
