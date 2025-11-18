import SwiftUI

struct SelectCountry: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCountry: String
    
    let countries = ["India", "Quatar", "Dubai", "Lebanon"]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                    Text("Change Country")
                        .font(.headline)
                }
                .foregroundColor(.primary)
                Spacer()
            }
            .padding()
            
            Divider()
            
            List(countries, id: \.self) { country in
                Button(action: {
                    selectedCountry = country
                    UserDefaults.standard.set(country, forKey: "selectedCountry")
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(country)
                        Spacer()
                        if selectedCountry == country {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .buttonStyle(.plain)
                .foregroundColor(.primary)
            }
            .listStyle(.plain)
        }
        .navigationBarHidden(true)
    }
}
