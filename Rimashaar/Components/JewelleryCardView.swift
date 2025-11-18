import SwiftUI

struct JewelleryCardView: View {
    let item: JewelleryItem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 170)
            .clipped()
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            .overlay {
                VStack(spacing: 5) {
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .padding(.top, 5)
                        
                    Text(item.name)
                        .font(.caption)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .padding(.horizontal, 5)
                    
                    Text("₹\(item.price)")
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                }
            }
    }
}
