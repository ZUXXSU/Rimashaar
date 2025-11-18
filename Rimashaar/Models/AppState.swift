import Foundation

enum AppState: Hashable {
    case registration
    case otp(firstName: String, lastName: String, emailOrPhone: String, phoneCode: String, responseData: RegistrationResponse.UserData, registrationData: RegistrationRequest)
    case startScreenOne
    case selectCountry
    case selectStore
    case welcomeScreen
}
