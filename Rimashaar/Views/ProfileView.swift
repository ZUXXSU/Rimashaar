import SwiftUI

struct ProfileView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Button(action: {
                        print("Sign In Tapped")
                    }) {
                        Text("Sign in".uppercased())
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(.quaternaryLabel))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        print("Sign Up Tapped")
                        path.append(AppState.registration)
                    }) {
                        Text("Sign Up".uppercased())
                            .font(.headline)
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(.systemBrown))
                            .cornerRadius(10)
                    }
                }
                
                VStack(spacing: 0) {
                    ProfileNavigationRow(icon: "globe", text: "Change Country") {
                        print("Change Country Tapped")
                    }
                    ProfileNavigationRow(icon: "info.bubble", text: "About Us") {
                        print("About Us Tapped")
                    }
                    ProfileNavigationRow(icon: "questionmark.circle", text: "FAQ’s") {
                        print("FAQ's Tapped")
                    }
                    ProfileNavigationRow(icon: "text.document", text: "Terms & Conditions") {
                        print("Terms & Conditions Tapped")
                    }
                    ProfileNavigationRow(icon: "phone", text: "Contact Us") {
                        print("Contact Us Tapped")
                    }
                }
            }
            .padding(20)
        }
        .padding(.top, 60)
    }
}

struct ProfileNavigationRow: View {
    let icon: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(text)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 15)
        }
        .buttonStyle(.plain)
        .foregroundColor(.primary)
    }
}
