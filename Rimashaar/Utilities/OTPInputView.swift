import SwiftUI

enum OtpField: Int, Hashable, CaseIterable {
    case field1 = 0
    case field2 = 1
    case field3 = 2
    case field4 = 3
    case field5 = 4
}

struct OTPInputView: View {
    @Binding var digits: [String]
    @FocusState.Binding var focusedField: OtpField?
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(OtpField.allCases, id: \.self) { field in
                TextField("", text: $digits[field.rawValue])
                    .frame(width: 50, height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .focused($focusedField, equals: field)
                    .onChange(of: digits[field.rawValue]) { oldValue, newValue in
                        processInput(field: field, value: newValue)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
            }
            Spacer()
        }
    }
    
    private func processInput(field: OtpField, value: String) {
        let newDigit = value.filter { $0.isNumber }.last.map(String.init) ?? ""
        digits[field.rawValue] = newDigit

        if !newDigit.isEmpty {
            if field.rawValue < OtpField.allCases.count - 1 {
                focusedField = OtpField(rawValue: field.rawValue + 1)
            } else {
                focusedField = nil
            }
        } else {
            if field.rawValue > 0 {
                focusedField = OtpField(rawValue: field.rawValue - 1)
            }
        }
    }
}
