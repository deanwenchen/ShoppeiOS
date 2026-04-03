import SwiftUI

// MARK: - Form Field Components
// These components are used by CreateAccount and other forms

struct FormField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            Text(placeholder)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "#D2D2D2"))

            Spacer()

            TextField("", text: $text)
                .keyboardType(keyboardType)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(60)
    }
}

struct PasswordField: View {
    @Binding var password: String
    @Binding var isPasswordVisible: Bool

    var body: some View {
        HStack(spacing: 12) {
            if isPasswordVisible {
                TextField("Password", text: $password)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            } else {
                SecureField("Password", text: $password)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }

            Spacer()

            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(hex: "#D2D2D2"))
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(60)
    }
}

struct PhoneNumberField: View {
    @Binding var phoneNumber: String
    @Binding var countryCode: String
    @Binding var showingCountryPicker: Bool

    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                showingCountryPicker = true
            }) {
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(hex: "#F0F0F0"))
                            .frame(width: 24, height: 18)

                        Image(systemName: "flag.fill")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                    }

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(hex: "#D2D2D2"))
                }
                .frame(height: 24)
            }

            Divider()
                .frame(height: 24)

            Text(countryCode)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "#202020"))

            Divider()
                .frame(height: 16)

            TextField("Your number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#F8F8F8"))
        .cornerRadius(60)
    }
}

struct CountryPickerView: View {
    @Binding var selectedCode: String
    @Environment(\.dismiss) var dismiss

    let countries: [(code: String, name: String, flag: String)] = [
        ("+1", "United States", "🇺🇸"),
        ("+44", "United Kingdom", "🇬🇧"),
        ("+86", "China", "🇨🇳"),
        ("+91", "India", "🇮🇳"),
        ("+81", "Japan", "🇯🇵"),
        ("+33", "France", "🇫🇷"),
        ("+49", "Germany", "🇩🇪"),
        ("+39", "Italy", "🇮🇹"),
        ("+34", "Spain", "🇪🇸"),
        ("+7", "Russia", "🇷🇺"),
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(countries, id: \.code) { country in
                    Button(action: {
                        selectedCode = country.code
                        dismiss()
                    }) {
                        HStack {
                            Text(country.flag)
                                .font(.system(size: 24))
                            Text(country.name)
                                .font(.system(size: 16, weight: .regular))
                            Spacer()
                            if selectedCode == country.code {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color(hex: "#004CFF"))
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
