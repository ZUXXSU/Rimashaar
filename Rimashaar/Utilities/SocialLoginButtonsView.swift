import SwiftUI

struct SocialLoginButtonsView: View {
    var body: some View {
        HStack {
            // Google Button
            Button {
                // TODO: Implement Google sign-in
            } label: {
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 50)
                    .overlay {
                        Image(Constants.Images.google)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10)
                    }
            }
            
            Spacer().frame(width: 20)

            // Facebook Button
            Button {
                // TODO: Implement Facebook sign-in
            } label: {
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(height: 50)
                    .overlay {
                        Image(Constants.Images.facebook)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(0)
                    }
            }
        }
    }
}
