import SwiftUI

struct MetalRateCardView: View {
    @Binding var selectedMetal: Metal
    let rates: RatesData
    
    var currentRate: String {
        switch selectedMetal {
        case .gold: return rates.gold.k24
        case .silver: return rates.silver.perGram
        case .platinum: return rates.platinum.perGram
        }
    }
    
    var rateUnit: String {
        switch selectedMetal {
        case .gold: return "₹/ gram (24k)"
        case .silver, .platinum: return "₹/ gram"
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            MetalSelectionToggle(selectedMetal: $selectedMetal)
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
                .frame(height: 120)
                .clipped()
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(selectedMetal.rawValue)
                                .font(.system(.headline, weight: .medium))
                        }
                        HStack {
                            Text(rateUnit)
                                .font(.system(.callout, weight: .light))
                        }
                        HStack(alignment: .bottom, spacing: 10) {
                            Text(currentRate)
                                .font(.system(size: 40, weight: .semibold, design: .default))
                            
                            let isPositive = rates.todayspercentage.starts(with: "+") || (Double(rates.todayspercentage) ?? 0 >= 0)
                            Text("\(rates.todayspercentage)%")
                                .foregroundStyle(isPositive ? .green : .red)
                                .font(.caption)
                                .fontWeight(.medium)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .clipped()
                        }
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                        .clipped()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipped()
                    .padding()
                }
        }
    }
}
