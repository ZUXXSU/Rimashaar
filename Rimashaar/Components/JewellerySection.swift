import SwiftUI

struct JewellerySection: View {
    let title: String
    let items: [JewelleryItem]
    let accentColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .regular, design: .default))
                Spacer()
                Text("View All")
                    .font(.system(size: 14, weight: .light, design: .default))
                    .underline()
                    .foregroundStyle(accentColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items) { item in
                        JewelleryCardView(item: item)
                    }
                }
            }
            .frame(height: 170)
            .clipped()
        }
    }
}
