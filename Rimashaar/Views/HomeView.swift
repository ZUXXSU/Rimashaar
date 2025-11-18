import SwiftUI

struct HomeView: View {
    @State private var allJewellery: [JewelleryItem] = Bundle.main.decode("jewellery.json")
    @State private var rates: RatesData = Bundle.main.decode("rates.json")
    @State private var bestSellerIDs: [String] = Bundle.main.decode("bestseller.json")
    @State private var featuredIDs: [String] = Bundle.main.decode("featured.json")

    @State private var selectedMetal: Metal = .gold
    
    let goldAccentColor = Color(.sRGB, red: 224/255, green: 173/255, blue: 2/255)
    
    var bestSellers: [JewelleryItem] {
        allJewellery.filter { bestSellerIDs.contains($0.id) }
    }
    
    var featuredItems: [JewelleryItem] {
        allJewellery.filter { featuredIDs.contains($0.id) }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                Spacer()
                    .frame(height: 20)
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.primary.opacity(0))
                    .frame(height: 200)
                    .clipped()
                    .background {
                        Image("main")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                Spacer()
                    .frame(height: 10)
                    .clipped()
                
                MetalRateCardView(selectedMetal: $selectedMetal, rates: rates)
                
                if selectedMetal == .gold {
                    GoldKaratRateView(rates: rates.gold)
                }

                Spacer()
                    .frame(height: 0)
                    .clipped()
                
                JewellerySection(title: "Best Seller", items: bestSellers, accentColor: goldAccentColor)
                
                JewellerySection(title: "Featured", items: featuredItems, accentColor: goldAccentColor)
            }
            .padding()
            Spacer()
                .frame(height: 40)
        }
        .padding(.top, 60)
        .background(Color.white)
    }
}
