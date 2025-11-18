import SwiftUI

struct OtpView: View {
    @Binding var path: NavigationPath
    @State private var digits: [String] = Array(repeating: "", count: 5)
    @FocusState private var focusedField: OtpField?
    @State private var isLoading = false
    @State private var toastMessage: String?
    @State private var isShowingToast = false
    
    let firstName: String
    let lastName: String
    let emailOrPhone: String
    let phoneCode: String
    let responseData: RegistrationResponse.UserData
    let registrationData: RegistrationRequest
    
    @State private var resendRemainingTime: Int = 30
    @State private var timer: Timer?
    
    private let apiService = APIService()

    private func startTimer() {
        timer?.invalidate()
        resendRemainingTime = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if resendRemainingTime > 0 {
                resendRemainingTime -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    private func resendCode() async {
        isLoading = true
        do {
            let response = try await apiService.registerUser(registrationData: registrationData)
            toastMessage = response.message ?? "OTP resent successfully."
            startTimer()
        } catch let error as APIError where error.localizedDescription.contains("406") {
            toastMessage = "Invalid User"
        } catch {
            toastMessage = error.localizedDescription
        }
        isLoading = false
        isShowingToast = true
    }
    
    private func verifyOtp() async {
        let otp = digits.joined()
        guard otp.count == 5 else { return }
        
        isLoading = true
        do {
            let success = try await apiService.verifyOtp(otp: otp, userId: responseData.id)
            if success {
                path.removeLast(path.count)
            } else {
                toastMessage = "Invalid OTP"
                isShowingToast = true
            }
        } catch {
            toastMessage = error.localizedDescription
            isShowingToast = true
        }
        isLoading = false
    }

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                HStack {
                    Spacer()
                    Button {
                        path.removeLast()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(.primary)
                    }
                }

                Image(Constants.Images.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Please enter OTP")
                        .font(.title2.weight(.semibold))
                    Text("Please enter the 5-digit code that was sent to your email address or phone number")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                OTPInputView(digits: $digits, focusedField: $focusedField)
                    .onChange(of: digits) { _, _ in
                        if digits.allSatisfy({ !$0.isEmpty }) {
                            Task { await verifyOtp() }
                        }
                    }

                HStack {
                    if resendRemainingTime > 0 {
                        Text(Constants.Strings.resendCodeIn)
                        Text(String(format: "00:%02d sec", resendRemainingTime))
                            .fontWeight(.medium)
                    } else {
                        Text(Constants.Strings.didNotReceiveCode)
                        Button(action: { Task { await resendCode() } }) {
                            Text(Constants.Strings.resendCode)
                                .underline()
                                .fontWeight(.medium)
                        }
                    }
                }
                .font(.subheadline)
                .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(20)
            .onAppear {
                startTimer()
                focusedField = .field1
            }
            .onDisappear {
                timer?.invalidate()
            }
            
            if isLoading {
                ProgressView().scaleEffect(2)
            }
            
            if isShowingToast {
                ToastView(message: toastMessage ?? "", isShowing: $isShowingToast)
            }
        }
        .navigationBarHidden(true)
    }
}
