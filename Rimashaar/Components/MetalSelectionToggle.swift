import SwiftUI

struct MetalSelectionToggle: View {
    @Binding var selectedMetal: Metal
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.white)
            .frame(height: 50)
            .clipped()
            .overlay {
                HStack {
                    ForEach(Metal.allCases) { metal in
                        Spacer()
                        Button {
                            selectedMetal = metal
                        } label: {
                            VStack {
                                Text(metal.rawValue)
                                    .fontWeight(selectedMetal == metal ? .semibold : .regular)
                                    .foregroundStyle(.primary)
                                if selectedMetal == metal {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(Color(.systemYellow))
                                }
                            }
                        }
                        Spacer()
                        if metal != Metal.allCases.last {
                            Divider()
                        }
                    }
                }
            }
    }
}
