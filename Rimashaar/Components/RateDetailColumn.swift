import SwiftUI

struct RateDetailColumn: View {
    let karat: String
    let rate: String
    
    var body: some View {
        VStack {
            Text(karat)
                .font(.system(size: 12, weight: .medium))
            Text(rate)
                .font(.system(size: 14, weight: .regular, design: .default))
        }
        .frame(maxWidth: .infinity)
    }
}
