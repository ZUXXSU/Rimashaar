import SwiftUI

struct GoldKaratRateView: View {
    let rates: RatesData.GoldRates
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.white)
            .frame(height: 75)
            .clipped()
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            .overlay {
                HStack {
                    Group {
                        RateDetailColumn(karat: "24 Karat", rate: rates.k24)
                        Divider()
                        RateDetailColumn(karat: "22 Karat", rate: rates.k22)
                        Divider()
                        RateDetailColumn(karat: "21 Karat", rate: rates.k21)
                        Divider()
                        RateDetailColumn(karat: "18 Karat", rate: rates.k18)
                    }
                }
                .padding(.horizontal, 5)
            }
    }
}
