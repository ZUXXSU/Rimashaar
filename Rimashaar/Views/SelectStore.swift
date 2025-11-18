import SwiftUI

struct SelectStore: View {
    @Binding var selectedStore: String
    @Binding var path: NavigationPath
    @State private var localSelectedStore: String

    let stores = [
        "Rimashaar Jewellery , location 1",
        "Rimashaar Jewellery , location 2",
        "Rimashaar Jewellery , location 3",
        "Rimashaar Jewellery , location 4"
    ]

    init(selectedStore: Binding<String>, path: Binding<NavigationPath>) {
        self._selectedStore = selectedStore
        self._path = path
        self._localSelectedStore = State(initialValue: selectedStore.wrappedValue)
    }

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Select Store")
                    .font(.title2)
                Text("Please select the store you wish to shop from")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            VStack(spacing: 15) {
                ForEach(stores, id: \.self) { store in
                    Button(action: {
                        localSelectedStore = store
                    }) {
                        Text(store)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(localSelectedStore == store ? Color.accentColor.opacity(0.2) : Color(.quaternaryLabel))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                selectedStore = localSelectedStore
                UserDefaults.standard.set(localSelectedStore, forKey: "selectedStore")
                path.append(AppState.welcomeScreen)
            }) {
                Text("Confirm".uppercased())
                    .font(.headline.weight(.semibold))
                    .foregroundColor(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.systemBrown))
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
}
