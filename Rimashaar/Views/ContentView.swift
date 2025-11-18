import SwiftUI

struct ContentView: View {
    @Binding var selectedCountry: String
    @Binding var selectedStore: String
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Image("img_intro")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            VStack(spacing: 20) {
                VStack {
                    Text("Selected country".uppercased())
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(selectedCountry)
                        .font(.title2)
                }

                VStack {
                    Text("Language".uppercased())
                        .font(.headline)
                        .foregroundColor(.secondary)
                    HStack(spacing: 40) {
                        Text("English")
                            .underline()
                            .font(.headline)
                        Text("日本語")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }

                Divider().padding(.vertical)

                HStack(spacing: 10) {
                    Button(action: {
                        path.append(AppState.selectCountry)
                    }) {
                        Text("Change country".uppercased())
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.quaternaryLabel))
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        path.append(AppState.selectStore)
                    }) {
                        Text("Continue".uppercased())
                            .font(.caption.weight(.semibold))
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(.systemBrown))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding(.vertical, 40)
        }
    }
}
